/*******************************************
 * IDENTIFY OLD VERSIONS
 *******************************************/

async function isNewest() {
  const currentUrl = window.location.href.toLowerCase();

  // 1. Early exit for local builds
  if (currentUrl.includes("/distribution/en-us")) return;

  // 2. Extract current version info
  // Expected format: .../spring2023/ or .../fall2023/
  const versionMatch = currentUrl.match(/\/(spring|fall)(\d{4})\//i);
  if (!versionMatch) return;

  const [fullMatch, season, yearStr] = versionMatch;
  const year = parseInt(yearStr);
  const baseUrl = currentUrl.split(fullMatch)[0];

  // 3. Determine the "Next" version string
  const isSpring = season.toLowerCase() === 'spring';
  const nextSeason = isSpring ? 'fall' : 'spring';
  const nextYear = isSpring ? year : year + 1;
  const nextReleaseUrl = `${baseUrl}/${nextSeason}${nextYear}/`;

  // 4. Date Logic: Should we even check yet?
  const now = new Date();
  const currentMonth = now.getMonth(); // 0-indexed (5 = June)
  const currentYear = now.getFullYear();

  // Logic: Check if we are past the release window (e.g., June 1st for Fall release)
  const isAfterMay = currentMonth >= 5;
  const shouldCheck = (currentYear > year) || (isSpring && isAfterMay);

  if (!shouldCheck) {
    console.log("On latest public release based on date logic.");
    return;
  }

  // 5. Asynchronous Check
  try {
    const response = await fetch(nextReleaseUrl, { method: 'HEAD' });

    if (response.ok) {
      showUpdateBanner();
    } else {
      console.log("No newer version found at:", nextReleaseUrl);
    }
  } catch (e) {
    console.warn("Update check failed. Likely offline or CORS restriction.", e);
  }
}

function showUpdateBanner() {
  if (document.getElementById('outOfDate')) return;

  const outOfDate = document.createElement('div');
  outOfDate.id = 'outOfDate';
  // Use a template literal for cleaner HTML
  outOfDate.innerHTML = `
    <div style="background: #ffeb3b; color: #000; padding: 1em; text-align: center; font-weight: bold; border-bottom: 2px solid #fbc02d;">
      These materials are OUT OF DATE! To get the latest version, visit
      <a href="https://www.BootstrapWorld.org/materials/latest/en-us">
        https://www.BootstrapWorld.org/materials/latest/en-us
      </a>
    </div>`;
  document.body.prepend(outOfDate); // Use prepend to put it at the top
}

/*******************************************
 * ATTACH COLLAPSIBLE EVENTS
 *******************************************/
function attachCollapsible() {
  // toggle collapsed state for a single lesson section
  function collapseOrExpand(header, action) {
    const content = header.nextElementSibling;
    if (action == "collapse") {
      header.classList.remove("active");
      content.style.maxHeight = null;
    } else {
      header.classList.add("active");
      content.style.maxHeight = "100%";
    }
  }

  // all the sections
  const headers = document.querySelectorAll(".LessonPlan h2, .TeacherResources .sect1 h2");

  headers.forEach( header => {
    // onClick, check to see if shift is pressed
    // toggle the relevant section if it's not, toggle ALL the sections if it is
    header.addEventListener("click", function(event) {
      if(event.target.parentNode.nodeName == "A") return;
      const toToggle = event.shiftKey? headers : [header];
      const action = header.classList.contains("active")? "collapse" : "expand";
      toToggle.forEach( h => collapseOrExpand(h, action));
    });
  });
}


/*******************************************
 * MATHJAX configuration
 *******************************************/
// for pages that use mathjax, this is the configuration string
// for those that don't, this is basically a no-op
MathJax = {
  options: { enableMenu: false, },
  tex:     {
    inlineMath: [['$$', '$$'], ['\\(', '\\)']],
    displayMath: [],
  },
  svg:     { fontCache: 'global' },
  startup: {
    ready: () => {
          MathJax.startup.defaultReady();
          MathJax.startup.promise.then(() => {
            window.status="MathJax Complete!"
          });
        }
  }
};

/*******************************************
 * CODEMIRROR
 *******************************************/
// translate all the TEXTAREA nodes into full-blown CM instances, and color TTs with runmode
// (we use the more expensive CM stuff for indenting)
function attachCodeMirror() {
  if(typeof CodeMirror == "undefined") return;
  const codeSnippets = document.querySelectorAll(
    "code.pyret, code.racket, tt.pyret, tt.racket"
  );
  try {
    codeSnippets.forEach(function (tt, idx) {
      const node = document.createElement("span");
      node.className = "editbox";
      tt.parentNode.insertBefore(node, tt);
      if (tt.className == "racket" && tt.firstChild) {
        CodeMirror.runMode(tt.firstChild.nodeValue, "scheme2", node);
      } else if (tt.className == "pyret" && tt.firstChild) {
        CodeMirror.runMode(tt.firstChild.nodeValue, "pyret", node);
      }
      tt.style.display = "none";
    });
  } catch(e) {
    console.error(e);
  }
}


/*******************************************
 * Quiz Functionality
 *******************************************/
async function postJSON(url, formData) {
  const response = await fetch(url, {
    method: "POST",
    body: formData
  });

  if (!response.ok) {
    throw new Error(`HTTP ${response.status}`);
  }

  return response.json();
}

// If the user is logged in, we'll get a salted hash about them.
async function fetchUserHash() {
  const formData = new FormData();
  formData.append('action', 'get_user_hash');

  return await postJSON('https://beta.bootstrapworld.org/wp-admin/admin-ajax.php',formData)
  .then(data => data.success? data.data : null)
  .catch(error => null);
}

async function populateQuizLinks() {
  let teacherId = await fetchUserHash(); // false or a real hash
  const quizLinks = [...document.querySelectorAll('a.quiz')];
  // if we have links but the user isn't logged in, display a helpful message
  if((quizLinks.length > 0) && !teacherId) {
      const directions = document.querySelector('.AssessmentDirections');
      directions.style.color = "darkred";
      directions.innerHTML = `To access assessments for this lesson, you must be <a href="https://beta.bootstrapworld.org/my-account/">logged in</a> to your teacher account.`;
  }
  quizLinks.forEach( link => {
    const quizLink = link.href;
    if(!teacherId) {
        link.style.setProperty("color", "gray", "important");
        link.href = null;
        link.style.pointerEvents = "none";
        return;
    }
    const quizBox = document.createElement('div');
    quizBox.className = 'quizBox';
    quizBox.innerHTML += `${link.innerHTML}
      <a title="Make a new link to this quiz" onclick="makeQuizLink(this, '${teacherId}', '${quizLink}')" class="makeQuizLink"/>
        <div class="makeQuizLinkImage"></div>
      </a>
      <input type="text" maxLength="40" placeholder="Name your class here and press Enter">
    <ul></ul>`;
    link.replaceWith(quizBox);
  })
}


async function fetchQuizId(teacher_hash, quiz_path, class_name) {
  const formData = new FormData();
  formData.append('teacher_hash', teacher_hash);
  formData.append('quiz_path', quiz_path);
  formData.append('class_name', class_name);

  return await postJSON('https://beta.bootstrapworld.org/data/GenerateAssessmentLink.php', formData)
  .then(data => {
    if (data.link_id) {
      return data.link_id
    } else {
      console.error('Error:', data.message);
      throw "Could not generate assessment link";
    }
  })
  .catch(error => null);
}

async function makeQuizLink(quizButtonLink, teacherId, quiz_path) {
  const quizBox = quizButtonLink.parentNode;
  const quizButtonImg = quizBox.querySelector('.makeQuizLinkImage');
  const linkList = quizBox.querySelector('ul');
  const textBox  = quizBox.querySelector('input');

  quizButtonImg.style.display = "none";
  textBox.style.display = "inline-block";

  function reset() {
    quizButtonImg.style.display = "inline-block";
    textBox.style.display = "none";
    textBox.value = null;
    textBox.removeEventListener("keydown", handleKeyDown);
  }
  textBox.addEventListener("blur", reset);

  async function handleKeyDown(event) {
    if (event.key === "Enter") {
      event.preventDefault(); event.stopPropagation();
      const class_name = textBox.value.trim();
      if (class_name.length == 0) { reset(); return; }
      // fetch a unique ID for this group
      const quizId = await fetchQuizId(teacherId, quiz_path, class_name);
      linkList.innerHTML += `<li><a href="${quiz_path}?groupId=${class_name}&teacherId=${teacherId}&assessmentId=${quizId}">${class_name}</a>`;
      reset();
    } else if (event.key === "Escape") { reset(); }
  }

  textBox.addEventListener("keydown", handleKeyDown);
}


/*******************************************
 * Stretch Tables
 *******************************************/
// tables with class .stretch need their colgroup settings
// manually-translated into css grid template rules
function fixStretchTables() {
  // if there's no header, use "auto" for row heights
  const tables = document.querySelectorAll('#body.workbookpage table.FillVerticalSpace');
  tables.forEach (t => {
    if(!t.querySelector(':scope > thead')) {
      t.style.gridTemplateRows = 'auto';
    }
    const cols = [...t.querySelector('colgroup').children];
    t.style.gridTemplateColumns = cols.map(c => c.style.width).join(" ")
  });
}

/*******************************************
 * Blanklines
 *******************************************/
function drawBlankLines() {
  const nodes = document.querySelectorAll('.blanklines');
  nodes.forEach( n => {
      // Get the computed style object for the element
      const computedStyle = window.getComputedStyle(n);

      // Create a temporary element to measure the 'normal' line-height
      // 'normal' is browser-dependent, so convert it to a pixel value
      let lineHeight = computedStyle.getPropertyValue('line-height');
      if (lineHeight === 'normal') {
        const tempDiv = document.createElement('div');
        tempDiv.style.visibility = 'hidden'; // Hide the element
        tempDiv.style.position = 'absolute'; // Prevent it from affecting layout
        tempDiv.style.height = 'auto'; // Allow height to be determined by content
        tempDiv.style.width = '1px'; // Minimal width
        tempDiv.innerHTML = '<br>'; // Add content to get a line height

        // Inherit font styles for accurate measurement
        tempDiv.style.fontSize = computedStyle.fontSize;
        tempDiv.style.fontFamily = computedStyle.fontFamily;

        // get the measured height, then clean up
        document.body.appendChild(tempDiv);
        lineHeight = tempDiv.offsetHeight;
        document.body.removeChild(tempDiv);
      }
      lineHeight = parseFloat(lineHeight) + 0.1;

      // Approximate the baseline, using the font-size with the line-height
      // It assumes the text content is roughly centered within the line box.
      const fontSize = parseFloat(computedStyle.getPropertyValue('font-size'));
      const leading = lineHeight - fontSize;
      const baselineOffset = fontSize + (leading / 2); // Distance from top of line box to estimated baseline

      // dynamically compute background SVG image with enough lines to fill the node
      const nodeHeight = n.getBoundingClientRect().height;
      const y = Math.round(baselineOffset);
      let dataUrl = 'data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg">';
      for (yOffset = 0; yOffset < nodeHeight; yOffset = Math.round(yOffset + lineHeight)) {
        dataUrl += `<line x1="0" y1="${y+yOffset}" x2="1000" y2="${y+yOffset}" style="stroke:black;stroke-width:1"/>`;
      }
      dataUrl += '</svg>';
      const marginTop = computedStyle.getPropertyValue('margin-top');
      n.style.height = `round(up, ${nodeHeight}px - ${marginTop} + 3px, 1px)`;
      n.style.backgroundImage = `url('${dataUrl}')`;
  });
}

/*******************************************
 * Utility Functions
 *******************************************/
function kebabToTitleCase(kebab) {
  const words = kebab.split('-');
  const normalizedWords = words.map(w => w.toLowerCase());
  const titleCaseWords = normalizedWords.map(w => w.charAt(0).toUpperCase() + w.slice(1));
  return titleCaseWords.join(" ");
}

// Given a page and lesson, produce the relative path name (using .html)
function formatPageURL(page, lesson) {
  return (`../../lessons/${lesson}/pages/${page}`).replace("adoc", "html");
}

/*******************************************
 * BUILD PAGE FROM DEPENDENCY GRAPH
 * Everything south of here relies on the dependency graph!
 * Changes to the graph will require changes to most of this code
 *******************************************/
const proglangs = "wescheme pyret codap spreadsheets none".split(new RegExp(" \+"));

// given a pathway, exract a list of lessons
const getPathwayLessons = pathway =>
  pathwayTocs[pathway].map(u=>u.lessons || u).flat();

function getParams() {
  const url = new URL(location);
  let {pathway, lessons, solns, lesson} = Object.fromEntries([...url.searchParams.entries()]);
  if(lessons)  lessons = lessons.split(",");
  if(!solns)   solns = false;


  // if a custom pathway is defined with lessons, do some verification
  if(pathway && lessons && lessons.length > 0) {
    if(lessons.some(l => !graph[l])) {
      console.error('At least one lesson in this custom pathway is unknown:', lessons.find(l=>!graph[l]));
      pathway = lessons = false; // render in standalone mode
    }
  }
  // if we're using a built-in pathway, use *those* lessons
  else if(pathway && pathwayTocs && pathwayTocs[pathway]) {
    lessons = getPathwayLessons(pathway); // use the lessons in this pathway
    //console.log('setting lessons to', lessons.join(','))
  }

  const path = window.location.pathname.split("/");
  const indexOfLessonFolder = path.findIndex(p => p == "lessons");
  lesson = (indexOfLessonFolder > -1)? path[indexOfLessonFolder + 1] : lesson;

  // take note of whether we are in wescheme or not
  const proglang = proglangs.find(pl => (pathway || lesson || "").includes(pl)) || "pyret";

/*
  console.log(
    "pathway is", pathway,
    "lesson is", lesson,
    "lessons are",lessons,
    "proglan is", proglang
    )
*/
  return {
    pathway: pathway,
    lessons: lessons,
    lesson: lesson,
    proglang: proglang,
    solns: solns

  };
}

// used with [].filter to produce an array of unique elts
const onlyUnique = (value, index, self) => self.indexOf(value) === index;

function configureGraph(graph) {

  // remove lessons that don't belong in the graph
  const lessonsToIgnore = [
    '__sample-lesson',
    '__sample-lesson-wescheme',
    '__sample-lesson-codap',
    'zample-lesson',
    'facilitator-slides-A',
    'facilitator-slides-DS',
    'hoc-wescheme-intro',
    'hoc-winter',
    'hoc-winter-parley',
  ];
  lessonsToIgnore.forEach(l => delete graph[l]);

  // add projects to the graph
  const projects = [
    {
      title: 'Make a Rocket Fly',
      path: 'functions-dr/',
      prerequisites: ['functions-dr'],
      description: 'Students make a rocket blast off, with a flight path following linear (straight-line), quadratic (accelerating or up-and-down), or exponential paths - depending on your learning goals. ',
    },
    {
      title: 'Protect a Butterfly',
      path: 'inequalities3-sam/',
      prerequisites: ['inequalities3-sam'],
      description: 'Students apply inequalities in the plane to protect a butterfly from going too far to each side of the screen, then explore compound inequalties (union/intersection and AND/OR to protect the butterfly on all sides at once.',
    },
    {
      title: 'Your Stress Level',
      path: 'filtering-and-building/pages/stress-project.html',
      prerequisites: ['box-plots'],
      description: 'People report being more and more stressed every day.  This trend is extending beyond adults, and is being reported by children and teenagers.  The amount of work people are responsible for has been increasing.  To understand what makes us feel stressed, students gather and analyze data about their own lives.',
    },
    {
      title: 'Snacking Habits',
      path: 'probability-inference/pages/food-habits-project.html',
      prerequisites: ['probability-inference'],
      description: 'Childhood obesity is a major problem in the U.S. Many have called for food producers to provide consumers with nutritional information so that consumers can make wiser choices. Students collect data on their own snacking habits, and compare it to national trends.',
    },
  ];
  projects.forEach((p) => {
    p.title = `Project: ${p.title}`;
    p.type = "project";
    graph[p.title] = p;
   });

  // set all required fields to the empty array
  const requiredFields = ["glossary", "prerequisites", "handouts", "pages", "optPages", "starterFiles", "primitives"];
  Object.values(graph).forEach(v => {
    requiredFields.forEach(f => v[f] ??= []);
  });

  // compute all prereqs for a given lesson
  const getTransitivePrereqs = (l, callingLesson = l) => {
    let prereqs = [];
    if(!graph[l]) {
        console.error(`getTransitivePrereqs ${callingLesson} requested an unknown lesson ${l}`);
    } else {
      prereqs = graph[l].prerequisites;
    }
    return prereqs.concat(...prereqs.map((x) => getTransitivePrereqs(x, l)));
  }

  // given two lesson titles, sort in prerequisite order
  const sortByPrereqs = (a,b) =>
    (graph[a].prerequisites.length < graph[b].prerequisites.length)? -1 : 1;

  // recursively compute all prerequisites for each lesson and project
  Object.keys(graph).forEach(k => {
    graph[k].prerequisites = getTransitivePrereqs(k)
      .filter(onlyUnique)
      .sort(sortByPrereqs)
  });
}

// process all the prior lessons in reverse order
// seed the prereqs with current lesson prereqs
function computeTransitiveData(lesson, pathway, lessons = false) {
  let priorLessons;
  // If we're looking at a lesson from a pathway
  if(lesson && lessons) {
    priorLessons = lessons.slice(0, lessons.indexOf(lesson) + 1);
  // If we're looking at a list of lessons
  } else if(!lesson && lessons) {
    priorLessons = lessons;
  } else {
    console.warn("Could not find a valid lesson list. Rendering page in standalone mode");
    try {
      // Build the transitive prereqs for this lesson - in order - and add lesson
      priorLessons = graph[lesson].prerequisites.concat([lesson]);
    } catch(e) {
      console.error('prerequisites were not defined for ', lesson)
    }
  }

  const formatItems = (items, lessonKey) =>
    (items || []).map(({ fileName, title }) => ({
      fileName: formatPageURL(fileName, lessonKey),
      title
    }));

  // given an accumulator and a lesson, (1) check if the lesson is in
  // the graph, and (2) if it is, process it and add to the accumulator
  function processLessonData(acc, l) {
    if(!graph[l]) {
      console.error('Skipping lesson', l, ': Not in dependency graph!', acc);
    }
    // update the accumulated glossary map
    let accGlossary = acc.glossary;
    let lessonGlossary = graph[l].glossary || [];
    lessonGlossary.forEach(({vocab, description}) => acc.glossary.set(vocab, description));

    return ({
      pathway: pathway,
      titles: acc.titles.concat([l]).filter(onlyUnique),
      handouts: formatItems(graph[l].handouts, l).concat(acc.handouts),
      pages: formatItems(graph[l].pages, l).concat(acc.pages),
      optPages: formatItems(graph[l].optPages, l).concat(acc.optPages),
      primitives: graph[l].primitives.concat(acc.primitives).filter(onlyUnique),
      prerequisites: graph[l].prerequisites.concat(acc.prerequisites).filter(onlyUnique),
      starterFiles: graph[l].starterFiles.concat(acc.starterFiles).filter(onlyUnique),
      optStarterFiles: graph[l].optStarterFiles.concat(acc.optStarterFiles).filter(onlyUnique),
      glossary: accGlossary
    });
  }

  // Return the prior data for all lessons up to and including this one
  return priorLessons.reduceRight(
    processLessonData,
    { titles: [], handouts: [], pages: [], optPages: [], primitives: [],
      prerequisites: [], starterFiles: [], optStarterFiles: [], glossary: new Map() });
}

function getStarterFileUrl(name, proglang) {
  const file = starterFiles[name];
  const isStarterFile = file[proglang].url.startsWith('https://raw.githubusercontent.com/bootstrapworld/starter-files')
  // if it's a pyret file, and no prefix key is defined, use the shareurl
  if (isStarterFile && (proglang == "pyret") && (file[proglang].prefix == undefined)) {
    return "https://pyret.BootstrapWorld.org/editor#shareurl=" + file[proglang].url;
  } else {
    return file[proglang].url;
  }
}

// Based on the dependency graph, customize the lesson plan
// 1. add page numbers to PrintableExercise links
// 2. populate the list of prerequisite lessons
// 3. populate the language table
// using the list of pathway lessons and workbook pages specified
// in the dependency graph
function populateLesson() {

  function populateMaterials(priorData) {
    const { pathway, lesson, proglang } = getParams();
    const lessonData = graph[lesson];

    // Pre-process priorData into Lookups for constant-time access
    const pageLookup = new Map(priorData.pages.map((p, i) => [p.fileName, i + 1]));
    const handoutSet = new Set(priorData.handouts.map(h => h.fileName));

    function makeCollapsiblePageList(container, isOptional, headerText) {
      if (!container) return;

      const pageList = isOptional
        ? lessonData.optPages
        : [...lessonData.pages, ...lessonData.handouts];

      if (pageList.length === 0) return;

      // set infinite windows, which get narrowed in the following loop
      let lowIndex = Infinity, highIndex = -Infinity;
      const itemsHTML = pageList.map(page => {
        const path = formatPageURL(page.fileName, lesson);
        const isHandout = handoutSet.has(path);
        const isWorkbookPage = !isHandout && !isOptional;
        const index = pageLookup.get(path) || 0;

        let label = "";
        if (isWorkbookPage && index > 0) {
          label = `<span class="pageNum">(Page ${index})</span>`;
          lowIndex = Math.min(lowIndex, index);
          highIndex = Math.max(highIndex, index);
        } else if (isHandout) {
          label = `<span class="pageNum">(handout)</span>`;
        }

        return `<li>
          <span class="PrintableExercise ${isOptional ? 'Optional' : ''}">
            <a href="${path}" target="_blank" rel="noopener">${page.title}</a>
          </span>${label}
        </li>`;
      }).join('');

      const rangeText = (!isOptional && lowIndex !== Infinity)
        ? (lowIndex === highIndex ? ` ${lowIndex}` : ` ${lowIndex}-${highIndex}`)
        : "";

      let workbookContext = "";
      if (pathway && !isOptional) {
        const isCustom = !pathwayTocs[pathway] && typeof lessons !== 'undefined';
        const attr = isCustom ? 'onclick="makeBook()"' : `href="../../courses/${pathway}/workbook/workbook.pdf"`;
        workbookContext = ` from the <a ${attr} target="_blank">Student Workbook</a>`;
      }

      container.classList.add('ulist');
      container.innerHTML = `
        <ul>
          <li class="noprint">
            <p>
              <a href="javascript:downloadLessonPDFs(${isOptional})">${headerText}${rangeText}</a>
              ${workbookContext}
              <span class="showPageLinks"><a onclick="togglePageLinks(this);"></a></span>
            </p>
            <div class="ulist"><ul>${itemsHTML}</ul></div>
          </li>
          ${generateStarterFilesHTML(isOptional)}
        </ul>`;
    }

    function generateStarterFilesHTML(isOptional) {
      const list = lessonData[isOptional ? 'optStarterFiles' : 'starterFiles'] || [];
      return list
        .filter(name => !["program-list", "editor"].includes(name))
        .map(name => `
          <li><p>
            <a href="${getStarterFileUrl(name, proglang)}" target="_blank">${starterFiles[name].title}</a>
          </p></li>`)
        .join('');
    }

    const reqContainer = document.querySelector(`#material-links`);
    const plural = lessonData.pages.length > 1 ? "s" : "";
    makeCollapsiblePageList(reqContainer, false, `PDF of all Handouts and Page${plural}`);

    // Append static links to the required list
    const reqUl = reqContainer?.querySelector('ul');
    if (reqUl) {
      if (lessonData.glossary.length)
        reqUl.insertAdjacentHTML('beforeend', `<li><p><a href="../../Glossary.shtml?lesson=${lesson}" target="_blank">Lesson Glossary</a></p></li>`);
      if (lessonData.slides)
        reqUl.insertAdjacentHTML('beforeend', `<li><p><a href="${lessonData.slides}" target="_blank">Lesson Slides</a></p></li>`);

      reqUl.insertAdjacentHTML('beforeend', `<li><p><a href="index.pdf" target="_blank">Printable Lesson Plan</a></p></li>`);
    }

    const optContainer = document.querySelector('#opt-material-links');
    makeCollapsiblePageList(optContainer, true, "Additional Printable Pages for Scaffolding and Practice");
  }

  // use the entire pathway or custom lesson list (if we have it)
  // otherwise use sorted prereqs
  function buildLessonSidebar(lesson, pathway, priorData) {

    // find the hidden sidebar nodes, and make the visible
    const sidebarstandards = document.querySelector('#sidebarstandards')
    sidebarstandards.style.display = 'inherit';
    const sidebarlessons = document.querySelector('#sidebarlessons')
    sidebarlessons.style.display = 'inherit';

    var lessonList = (pathway && getPathwayLessons(pathway)) || lessons;
    if(!lessonList) {
      lessonList = priorData.titles.reverse();
    }

    var lessonDOMList = sidebarlessons.querySelector("ul");
    lessonList.forEach((l, i) => {
      if(!graph[l]) { return; } // if it's not in the graph, skip
      var li = document.createElement('li');
      var linkHTML = "<a href='../" + l + "/index.shtml"
       + (pathway? "?pathway="+pathway : "")
       + "'>" + graph[l].title + "</a>";
      li.innerHTML = linkHTML;
      lessonDOMList.appendChild(li);
    });

    const title = document.querySelector('#sidebarlessons h4');
    if(!title) { console.error('EXCEPTION: no title was found'); }
    else if(pathway) {
      title.innerHTML = `<h4 class="x-text-content-text-primary">Lessons</h4>`;
    }
    title.innerHTML += `<p/>`;
  }

  // if there's no pathway defined, hide all pathway-only content
  // show/hide pathway-specific content
  function checkPathwaySpecificContent(pathway) {
    const shows = document.querySelectorAll("[class^=pathway-]");
    const hides = document.querySelectorAll("[class^=notpathway-]");
    shows.forEach(n => {
      n.style.display = n.classList.contains("pathway-"+pathway)? null : "none";
    });
    hides.forEach(n => {
      n.style.display = n.classList.contains("notpathway-"+pathway)? "none" : null;
    });
    if(pathway) { // if there is a pathway, adorn certain links with it
      [...document.querySelectorAll('[href$="Contracts.shtml"]')]
        .forEach(n => n.href += `?pathway=${pathway}`)
    };
    const nodes = [...document.querySelectorAll('.pathway-only')];
    nodes.forEach(n => {
      if(!pathway){ n.style.display = 'none'; }
      else { n.style.display = ''; }
    });
  }

  // if there's no graph, log to the console and hide the placeholder
  if ((typeof graph == "undefined") || !graph) {
    console.error("Dependency graph did not load! This lesson may not render correctly");
    document.querySelectorAll('.materialSectionPlaceholder').forEach( n =>
      n.parentNode.parentNode.remove());
    return;
  }

  // get the pathway, lessons names and current lesson from the URL
  const {pathway, lessons, lesson, proglang} = getParams();
  if(!lesson) {
    console.log('Not a lesson - will skip populateLessonFromGraph()');
    return;
  }

  if(!pathway || !pathwayTocs[pathway]) {
    if(lessons && !lessons.includes(lesson)) pathway = false;
  }
  // get prior data for every lesson in the pathway (or prereqs, if pathway is false)
  const priorData = computeTransitiveData(lesson, pathway, lessons);

  console.log(
    "pathway is", pathway,
    "lesson is", lesson,
    "pathwayLessons are", lessons,
    "prior lessons are", priorData.titles,
    "prior data is", priorData);


  // If pathway is defined, add the title
  try {
    checkPathwaySpecificContent(pathway); // show/hide pathway-specific content
  } catch (e) { console.log('checkPathwaySpecificContent', e); }
  try {
    populateMaterials(priorData);
  } catch (e) { console.log('populateMaterials', e); }
  try {
    // only compute prereqs for the currently-active lesson
    addPrereqs(computeTransitiveData(lesson, false, false).prerequisites);
  } catch (e) { console.log('addPrereqs', e); }
  try {
    buildLessonSidebar(lesson, pathway, priorData);
  } catch (e) { console.log('buildLessonSidebar', e); }
  try {
    populateLessonAlignment(lesson);
    showAlignment('standards-CCSS-Math');
  } catch (e) { console.log('adding Alignments', e); }


  function addPrereqs(prereqs) {
    if (!prereqs || prereqs.length < 1) return;

    let sortedPrereqs = [...new Set(prereqs)]; // Ensure uniqueness
    if (pathway && pathwayTocs[pathway]) {
      const pathwayOrder = getPathwayLessons(pathway);
      sortedPrereqs.sort((a, b) => pathwayOrder.indexOf(a) - pathwayOrder.indexOf(b));
    }

    const tr = document.createElement('tr');
    tr.innerHTML = `
      <td class="tableblock halign-left valign-top">
        <div class="content"><div class="paragraph"><p>Prerequisites</p></div></div>
      </td>
      <td class="tableblock halign-left valign-top">
        <div class="content">
          <div class="ulist"><ul></ul></div>
        </div>
      </td>`;

    const ul = tr.querySelector('ul');

    sortedPrereqs.forEach(l => {
      if (!graph[l]) return;
      const li = document.createElement('li');
      li.innerHTML = `<p><a href="../${l}/index.shtml?pathway=${pathway}">${graph[l].title}</a></p>`;
      ul.appendChild(li);
    });

    const rows = Array.from(document.querySelectorAll('table.preamble tr'));
    const materialsRow = rows.find(row => row.textContent.includes('Materials'));
    const tbody = document.querySelector('table.preamble tbody');

    if (materialsRow && tbody) {
      tbody.insertBefore(tr, materialsRow);
    } else if (tbody) {
      tbody.appendChild(tr); // Fallback if "Materials" isn't found
    }
  }
}

function togglePageLinks(node, optPages) {
  const grandparent = node.parentNode.parentNode;
  grandparent.classList.toggle("open");
}

// if there's a proglang suffix, remove it
function removeProglangSuffix(lessonName) {
  const lessonTokens = lessonName.split('-');
  const lastToken = lessonTokens.pop();
  return proglangs.includes(lastToken)? lessonTokens.join('-') : lessonName;
}

/*******************************************
 * STANDARDS
 *******************************************/

const stateMap = new Map([
  ["AL", "Alabama"],
  ["AK", "Alaska"],
  ["AZ", "Arizona"],
  ["AR", "Arkansas"],
  ["CA", "California"],
  ["CO", "Colorado"],
  ["CT", "Connecticut"],
  ["DE", "Delaware"],
  ["DC", "District of Columbia"],
  ["FL", "Florida"],
  ["GA", "Georgia"],
  ["HI", "Hawaii"],
  ["ID", "Idaho"],
  ["IL", "Illinois"],
  ["IN", "Indiana"],
  ["IA", "Iowa"],
  ["KS", "Kansas"],
  ["KY", "Kentucky"],
  ["LA", "Louisiana"],
  ["ME", "Maine"],
  ["MD", "Maryland"],
  ["MA", "Massachusetts"],
  ["MI", "Michigan"],
  ["MN", "Minnesota"],
  ["MS", "Mississippi"],
  ["MO", "Missouri"],
  ["MT", "Montana"],
  ["NB", "Nebraska"],
  ["NV", "Nevada"],
  ["NH", "New Hampshire"],
  ["NJ", "New Jersey"],
  ["NM", "New Mexico"],
  ["NY", "New York"],
  ["NC", "North Carolina"],
  ["ND", "North Dakota"],
  ["OH", "Ohio"],
  ["OK", "Oklahoma"],
  ["OR", "Oregon"],
  ["PA", "Pennsylvania"],
  ["RI", "Rhode Island"],
  ["SC", "South Carolina"],
  ["SD", "South Dakota"],
  ["TN", "Tennessee"],
  ["TX", "Texas"],
  ["UT", "Utah"],
  ["VT", "Vermont"],
  ["VA", "Virginia"],
  ["WA", "Washington"],
  ["WV", "West Virginia"],
  ["WI", "Wisconsin"],
  ["WY", "Wyoming"]]);

const ccStates = [
  "AL", "AR", "CA", "CO", "CT", "DE", "DC", "GA", "HI", "ID", "IL",
  "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MS", "MO", "MT",
  "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OR", "PA", "RI",
  "SD", "TN", "UT", "VA", "VT", "WA", "WV", "WI", "WY"];

const cstaStates = [
  "AK", "CT", "DE", "HI", "IA", "ID", "IL", "MD", "MI", "MS", "NH",
  "NM", "PA", "OR", "WA"];

function populateLessonAlignment(lesson) {

  // get DOM for alignment parent and alignment dropdown menu
  const dictParent = document.querySelector('#WholePageAlignment')
    || document.querySelector('#sidebarstandards .content');
  const dropdown = document.getElementsByClassName('alignmentSelect')[0];
  const url = new URL(location);

  // add a group of standards to the page
  function addGroup(keyName, groupLabel) {
    console.log('adding', groupLabel);
    // add the dropdown optgroup
    const group = document.createElement('optgroup');
    group.label = groupLabel;

    // Walk over dictionaries, adding an alignment div for each
    for( const [dict, stds] of Object.entries(dictionaries[keyName]) ) {
      let {fullname, url:stdUrl} = stds['__metadata'];
      // build the alignment div, and add a dictionary list to it
      const div = document.createElement('div');
      div.classList.add('dlist', 'alignedStandards', keyName+'-'+dict);
      div.innerHTML = `<div class="title">
        <h2><a href="${stdUrl}">${fullname}</a></h2>
      </div><dl></dl>`;
      const list = div.querySelector('dl')

      // Walk over entries, adding each to the list if it aligns with the current lesson
      // SKIP __metadata, which does not contain a 'lessons' field
      for( const [id, std] of Object.entries(stds) ) {
        if(std.lessons && std.lessons.includes(removeProglangSuffix(lesson))) {
          list.innerHTML += `<dt>${id}</dt><dd><p>${std.description}</p></dd>`
        }
      }
      div.appendChild(list);
      dictParent.append(div);

      // if we actually have alignments and they aren't state-specific,
      // add them to the page and optgroup
      if (list.children.length > 0 && !stateMap.get(dict)) {
        const opt = document.createElement('option');
        opt.value = keyName + '-' + dict;
        opt.appendChild(document.createTextNode(fullname));
        group.append(opt);
      }
    }

    // add non-empty groups to the dropdown
    if (group.children.length > 0) {
      dropdown.appendChild(group);
    }
  }

  // Add Menu Groups for all the built-in alignment dictionaries
  addGroup("standards", "By Standard");
  addGroup("practices", "By Practice");
  addGroup("textbooks", "By Textbook");

  // Add Menu Group for states
  const stateGroup = document.createElement('optgroup');
  stateGroup.label = "By State";
  [...stateMap.entries()].forEach(entry => {
    const opt = document.createElement('option');
    opt.value = 'standards-'+entry[0];
    opt.appendChild(document.createTextNode(entry[1]));
    stateGroup.appendChild(opt);
  });
  dropdown.appendChild(stateGroup);
}

function showAlignment(selection) {
  // hide all the standards tables
  [...document.getElementsByClassName('alignedStandards')]
    .forEach(t => t.style.display = 'none');

  // bail if there's no selection
  if(!selection) return;

  function copyStandards(source, dest) {
    const stds = document.querySelector(source+' dl');
    if(!stds) return; // if the table doesn't exist, skip
    [...stds.children].forEach(n => dest.appendChild(n.cloneNode(true)));
  }

  const dictParent = document.querySelector('#WholePageAlignment')
    || document.querySelector('#sidebarstandards .content');

  // Can't use querySelector, since some selection values contain dots
  let stdTable = document.getElementsByClassName(selection)[0];

  // If we don't have an alignment div for this, make one and add it
  if(!stdTable) {
    stdTable = document.createElement('div');
    stdTable.classList.add('dlist', 'alignedStandards', selection);
    stdTable.innerHTML = '<div class="title"></div><dl></dl>';
  }
  stdEntries = stdTable.querySelector('dl');
  if(!stdTable.getAttribute('complete')) {
    // Add any copycat standards for common core and csta
    if(ccStates.includes(selection.slice(10))) {
      copyStandards('.standards-CCSS-Math', stdEntries);
      copyStandards('.standards-CCSS-ELA', stdEntries);
    }
    if(cstaStates.includes(selection.slice(10))) {
      copyStandards('.standards-CSTA', stdEntries);
    }
    // If there isn't any alignment info, say so
    if(stdEntries.children.length == 0) {
      stdEntries.innerHTML = "<dt class='hdlist1'>Alignment not yet available</dt>";
    }
    stdTable.setAttribute('complete', true);
  }
  dictParent.appendChild(stdTable);

  // Get the relevant table, and add copycat standards if it has them
  if(!stdTable) throw `ERROR: no standards table exists for ${selection}`;
  else if(stdTable.length > 1) throw "ERROR: two standards tables have the same name";

  stdTable.style.display = 'block';
}

function populateTeacherResources() {
  const { lesson, pathway, lessons } = getParams();
  const container = document.querySelector('#lesson-info-table');
  const table = document.createElement("table");
  table.innerHTML = `
    <thead>
      <tr>
        <th>Lesson</th>
        <th>Slides & Notes</th>
        <th>Starter Files</th>
      </tr>
    </thead>
    <tbody>
    </tbody>`;
  const data = computeTransitiveData(lesson, pathway, lessons);
  const tbody = table.querySelector('tbody');
  const proglang = graph[lessons[0]].proglang;
  lessons.filter(l => !l.includes("project-")).forEach(l => {
    const {title, slides, notes, starterFiles:starters} = graph[l];
    const row = document.createElement('tr');
    let rowStr = "";
    rowStr = `
      <td>
        <a href="../../../lessons/${l}/index.shtml">${title}</a>
      </td>
      <td>
        [<a href="${slides}">Slides</a>]`;
    if(notes.length) {
      rowStr += `<br>[<a href="../../../lessons/${l}/pages/${notes[0].replace('adoc','html')}">Notes</a>]`
    }
    rowStr += `</td><td>`
    rowStr += starters
      .filter(name => !["editor", "program-list"].includes(name))
      .map(name => {
        let fileName = starterFiles[name].title
          .replace('Starter File','')
          .replace('Flag of', '')
          .replace('Flags of', '')
          .replace('(Desmos)', '');
        return `[<a href="${getStarterFileUrl(name, proglang)}">${fileName.trim()}</a>]`
      })
      .join(' ');
    rowStr += `</td></tr>`;
    row.innerHTML = rowStr;
    tbody.appendChild(row);
  })
  container.appendChild(table);

  const solutions = document.querySelector('#exercises_and_solutions');
  solutions.innerHTML = `<div class="paragraph">
<p>Exercises and solutions are grouped by lesson, below. Most of these are part of the
<strong><a href="../workbook/workbook.pdf">Student Workbook</a></strong>,
and we provide password-protected <strong>
<a href="./protected/workbook-sols.pdf">Workbook Solutions</a></strong> as well.</p>
</div><p/>`;
  lessons.forEach(l => {
    if(l.includes("project-")) { return; } // no exercises for projects
    const lessonDiv = document.createElement('div');
    const paragraph = document.createElement('p');
    const openCloseWidget = document.createElement('span');
    const lessonPath = `../../../lessons/${l}`;
    const allPages = graph[l].pages.concat(graph[l].optPages);
    openCloseWidget.className = "showPageLinks";
    openCloseWidget.innerHTML = `<a onclick="togglePageLinks(this);"></a>`
    if(allPages.length == 0) {
      openCloseWidget.innerHTML = ` (no exercises)`;
    }
    lessonDiv.className = "materials-links";
    paragraph.innerHTML = `<a style="font-weight:bold;" href="${lessonPath}">${graph[l].title}</a>`
    paragraph.appendChild(openCloseWidget);
    lessonDiv.appendChild(paragraph)
    // Add the lesson link and open/close triangle
    lessonDiv.innerHTML += `
      <div class="ulist"><ul>` + allPages.map(({fileName, title}) =>
        `<li>${title} <span class="pageNum">[
        <a href="${lessonPath}/pages/${fileName.replace('adoc', 'html')}">exercise</a> |
        <a href="${lessonPath}/solution-pages/${fileName.replace('adoc', 'html')}">solution</a>
        ]</span></li>`)
        .join('') + `</ul>
      </div>`;
    solutions.appendChild(lessonDiv)
  });
}

/*******************************************
 * PRINTING FUNCTIONS
 *******************************************/
function downloadLessonPDFs(optPages) {
  const { lesson } = getParams();
  // set the opts object based on whether we're printing optpage or not
  const opts = { reqPages: !optPages, optPages: optPages }
  makeCustomBook(graph[lesson].title, [lesson], opts);
}

/*******************************************
 * EVENT HANDLERS
 *******************************************/
// if we're in a browser, attach event handlers
if(typeof document !== 'undefined') {
  document.addEventListener('DOMContentLoaded', async () => {
    fixStretchTables();
    attachCodeMirror();
    drawBlankLines();

    if(typeof module == 'undefined') { await populateQuizLinks(); }

    const bodyDivClasses = document.getElementById('body').classList;
    if(!bodyDivClasses.contains("workbookpage")) {
      configureGraph(graph);
      //isNewest();
      attachCollapsible();
    }
    if(bodyDivClasses.contains("TeacherResources")) { populateTeacherResources(); }
    if(bodyDivClasses.contains("LessonPlan"))       { populateLesson();           }
  });
}

// if we're in node, provide the module exports
if(typeof module !== 'undefined'){
  module.exports = {
    configureGraph: configureGraph,
  };
}
