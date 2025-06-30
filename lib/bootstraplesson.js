/*******************************************
 * IDENTIFY OLD VERSIONS
 *******************************************/
function UrlExists(url) {
  var http = new XMLHttpRequest();
  http.open('HEAD', url, false); // TODO: change this to 'true' and use a promise to render the out of date banner
  http.send();
  console.log('checking for', url, 'status is', http.status)
  return (http.status == 200)
}

function isNewest() {
  var url = window.location.href.toLowerCase();

  // if we're building locally, don't bother to check
  if(url.includes("/distribution/en-us")) return;

  // Generate the URL for the *next* version of the curriculum
  var url_year = parseInt(url.match(/(\d{4})\//)[1]);
  var release = url.slice(0, url.indexOf(url_year) + 4);
  var current_date = new Date();
  var current_month = current_date.getMonth();
  var current_year = current_date.getFullYear();

  var next_release = (release.match(/\/spring/i))? release.replace("/spring", "/fall")
    : release.replace(/\/fall\d{4}/, "/spring" + (url_year+1));
  var next_year = parseInt(next_release.match(/(\d{4})/)[1]);

  // is the next release in the fall of this year?
  var fall_year = next_release.match(/fall(\d{4})/);
  var this_fall = fall_year && (fall_year[1] == current_year)

  // if the next release is the following year, OR it's this fall and we're past May 31st, we need to check
  if ((current_year < next_year) || (this_fall && (current_month >= 6))) {
    try {
      // If that version exists, throw up a warning
      if(UrlExists(next_release)) {
        var outOfDate = document.createElement('div');
        outOfDate.setAttribute('id', 'outOfDate');
        outOfDate.innerHTML = 'These materials are OUT OF DATE! To get the latest version'
          + ' of the materials, visit <a href="https://www.BootstrapWorld.org/materials">'
          + 'https://www.BootstrapWorld.org/materials/latest/en-us</a>';
        document.body.appendChild(outOfDate);
      } else {
        console.log("checked for",release,", and it does not exist. This must be the recent version!");
      }
    } catch(e) {
      console.log("Could not check for newer version. Perhaps you are running locally?");
    }
  } else {
    console.log("Congratulations - you are on the latest public release!");
  }
}

/*******************************************
 * ATTACH OPEN/CLOSE EVENTS TO LESSON SIDEBAR
 *******************************************/
function sidebarToggleEvent() {
  var sidebar = document.getElementsByClassName("sidebar")[0];
  var toggle = document.getElementById("toggle");
  if(!toggle) return; // probably not a lesson
  toggle.onclick = function () {
    sidebar.classList.toggle("closed");
    sidebarToggleEvent();
  }
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

  headers.forEach(function(header) {
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
  var codeSnippets = document.querySelectorAll(
    "code.pyret, code.racket, tt.pyret, tt.racket"
  );
  try {
    codeSnippets.forEach(function (tt, idx) {
      var node = document.createElement("span");
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
 * Stretch Tables
 *******************************************/
// tables with class .stretch need their colgroup settings
// manually-translated into css grid template rules
function fixStretchTables() {
  // if there's no header, use "auto" for row heights
  var tables = document.querySelectorAll('#body.workbookpage table.FillVerticalSpace');
  tables.forEach (t => {
    if(!t.querySelector(':scope > thead')) {
      t.style.gridTemplateRows = 'auto';
    }
    var cols = [...t.querySelector('colgroup').children];
    t.style.gridTemplateColumns = cols.map(c => c.style.width).join(" ")
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
  return ("../../lessons/" + lesson + "/pages/" + page).replace("adoc", "html");
}

/*******************************************
 * BUILD PAGE FROM DEPENDENCY GRAPH
 * Everything south of here relies on the dependency graph!
 * Changes to the graph will require changes to most of this code
 *******************************************/
const proglangs = "wescheme pyret codap spreadsheets none".split(new RegExp(" \+"));

function getParams() {
  const url = new URL(location);
  var {pathway, lessons, solns, lesson} = Object.fromEntries([...url.searchParams.entries()]);
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
    lessons = pathwayTocs[pathway]; // use the lessons in this pathway
    //console.log('setting lessons to', lessons.join(','))
  }

  var path = window.location.pathname.split("/");
  var indexOfLessonFolder = path.findIndex(p => p == "lessons");
  var lesson = (indexOfLessonFolder > -1)? path[indexOfLessonFolder + 1] : lesson;

  // take note of whether we are in wescheme or not
  const proglang = proglangs.find(pl => (pathway || lesson || "").includes(pl)) || "pyret";

/*
  console.log(
    "pathway is", pathway,
    "lesson is", lesson,
    "lessons are",lessons,
    "proglan is", proglang)
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
  var projects = [
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
    p.title = "Project: " + p.title;
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
        console.error("getTransitivePrereqs: " + callingLesson + " requested an unknown lesson " + l);
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
  var priorLessons;
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
      handouts: graph[l].handouts.map(({fileName, title}) => {
        return {fileName:formatPageURL(fileName, l), title: title};
      }).concat(acc.handouts),
      pages: graph[l].pages.map(({fileName, title}) => {
        return {fileName:formatPageURL(fileName, l), title: title};
      }).concat(acc.pages),
      optPages: graph[l].optPages.map(({fileName, title}) => {
        return {fileName:formatPageURL(fileName, l), title: title};
      }).concat(acc.optPages),
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

// Based on the dependency graph, customize the lesson plan
// 1. add page numbers to PrintableExercise links
// 2. populate the list of prerequisite lessons
// 3. populate the language table
// using the list of pathway lessons and workbook pages specified
// in the dependency graph
function populateLesson() {

  function populateMaterials(priorData) {
    const { pathway, lesson, proglang } = getParams();

    function makeCollapsiblePageList(container, isOptional, text) {
      // set up the container, the pageList, and the materialsList DOM
      container.classList.add('ulist');
      container.innerHTML = '<ul></ul>'; // replace empty placeholder with UL
      const pageList = isOptional? graph[lesson].optPages
        : graph[lesson].pages.concat(graph[lesson].handouts);
      materialsList = container.querySelector('ul');

      // if there are pages, render the collapsible sublist
      if(pageList.length > 0) {
        container.querySelector('ul').innerHTML = `
          <li class="noprint"><p><a href="javascript:downloadLessonPDFs(${isOptional})">${text}</a></p>
          <div class="ulist"><ul></ul></div></li>`;
        const bullet = materialsList.children[0];
        const pagesLink   = bullet.querySelector('a');
        const pageSublist = bullet.querySelector('ul');

        // For every page, add a link and keep track of page numbers and page ranges
        let lowIndex, highIndex;
        pageList.forEach(({fileName:path, title:text}) => {
          path = formatPageURL(path, lesson);
          const isHandout = priorData.handouts.find(({fileName, title}) => fileName == path);
          const isWBPage = !isHandout && !isOptional;

          const index = priorData.pages.findIndex(({fileName, title}) => fileName == path) + 1;
          let html = `<li><span class="PrintableExercise ${isOptional? "Optional" : ""}">
            <a href="${path}" target="_blank" rel="noopener">${text}</a></span>`;

          // If it's a workbook page...
          // Log an error if it doesn't show up in priorData
          // If we're in a pathway, add page number
          if(isWBPage) {
            if (index<1){ console.error(`link ${path} doesn't match a workbook page`); }
            if(pathway) { html += `<span class="pageNum">(Page ${index})</span>`; }
            if (!lowIndex  || index <= lowIndex) lowIndex  = index;
            if (!highIndex || index > highIndex) highIndex = index;
          } else if(isHandout) {
            html += `<span class="pageNum">(handout)</span>`;
          }
          html += `</li>`;

          pageSublist.innerHTML += html;
        });

        // If there's a pathway, add link to student workbook for required pages
        if(!isOptional && graph[lesson].pages.length) {
          if(lowIndex == highIndex) pagesLink.innerHTML += ` ${lowIndex + 1}`;
          else pagesLink.innerHTML += ` ${lowIndex}-${highIndex}`;
        }
        let studentWorkbookHTML;
        if(pathway && !isOptional) {
          const workbookLink = `../../courses/${pathway}/workbook/workbook.pdf`;
          studentWorkbookA = `<a href="${workbookLink}" target="_blank">`;
          if(!pathwayTocs[pathway] && lessons) {
             studentWorkbookA = `<a href="javascript:void(0)" onclick="makeBook()">`;
          }
          bullet.firstChild.innerHTML += " from the " + studentWorkbookA + "Student Workbook</a>";
        }

        // Add the triangle to open and close the pageSublist
        bullet.firstChild.innerHTML += `<span class="showPageLinks">
          <a onclick="togglePageLinks(this);"></a>
        </span>`;
      }

      // add starter file list
      let starterBullets = "";
      const starterList = graph[lesson][(isOptional? 'optStarterFiles' : 'starterFiles')]
      starterList.forEach(name => {
        if (["program-list", "editor"].includes(name)) return; // skip program-list and editor
        const file = starterFiles[name];
        starterBullets += `<li><p>
            <a href="${file[proglang].url}" target="_blank">${file['title']}</a>
          </p></li>`
      })
      materialsList.innerHTML += starterBullets;
    }

    // REQUIRED: build the collapsible page list, then
    // add other bullets+links for starter files, glossary, slide deck, and PDF
    const requiredContainer = document.querySelector(`#material-links`);
    makeCollapsiblePageList(requiredContainer, false, "PDF of all Handouts and Pages");
    const requiredMaterials = requiredContainer.querySelector('ul');

    let otherBulletsHTML = "";
    if (graph[lesson].glossary.length !== 0) {
      otherBulletsHTML += `
      <li><p><a href="../../Glossary.shtml?lesson=${lesson}" target="_blank">Lesson Glossary</a></p></li>`;
    }
    if(graph[lesson].slides) {
      otherBulletsHTML += `<li><p><a href="${graph[lesson].slides}" target="_blank">Lesson Slides</a></p></li>`;
    }
    otherBulletsHTML += `
      <li><p><a href="index.pdf" target="_blank">Printable Lesson Plan</a> (a PDF of this web page)</p></li>`;
    requiredMaterials.innerHTML += otherBulletsHTML;
    requiredContainer.innerHTML += `<p><span id="status" style="display: none;"><label for="file">Assembling Pages:</label><progress id="file" max="3" value="3"></progress></span></p>`;

    // OPTIONAL: build the collapsible page list, then add contracts reference
    const optContainer = document.querySelector(`#opt-material-links`);
    if(!optContainer) { return; } // not every page has optional materials
    makeCollapsiblePageList(optContainer, true, "Additional Printable Pages for Scaffolding and Practice");
    const optMaterials = optContainer.querySelector('ul');
    if(["pyret", "wescheme"].includes(proglang)) {
      optMaterials.innerHTML += `
        <li><p><a href="../../Contracts.shtml?pathway=${pathway}">Contracts Reference</p></li>`
    }
  }

  // use the entire pathway or custom lesson list (if we have it)
  // otherwise use sorted prereqs
  function buildLessonSidebar(lesson, pathway, priorData) {
    var lessonList = (pathway && pathwayTocs[pathway]) || lessons;
    if(!lessonList) {
      lessonList = priorData.titles.reverse();
    }
    var sidebarSection = document.getElementsByClassName("sidebarlessons")[0];
    var lessonDOMList = sidebarSection.getElementsByTagName("ul")[0];
    lessonList.forEach((l, i) => {
      if(!graph[l]) { return; } // if it's not in the graph, skip
      var li = document.createElement('li');
      var linkHTML = "<a href='../" + l + "/index.shtml"
       + (pathway? "?pathway="+pathway : "")
       + "'>" + graph[l].title + "</a>";
      li.innerHTML = linkHTML;
      lessonDOMList.appendChild(li);
    });

    const title = document.querySelector('.sidebarlessons strong');
    if(!title) { console.error('EXCEPTION: no title was found'); }
    else if(pathway) {
      title.innerHTML = `
        <a href="../../courses/${pathway}/index.shtml">
        ${kebabToTitleCase(pathway)} Lessons</a>`;
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
        .forEach(n => n.href += "?pathway=" + pathway)
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
  var {pathway, lessons, lesson, proglang} = getParams();
  if(!lesson) {
    console.log('Not a lesson - will skip populateLessonFromGraph()');
    return;
  }

  if(!pathway || !pathwayTocs[pathway] || !pathwayTocs[pathway].includes(lesson)) {
    pathway = false;
  }
  // get prior data for every lesson in the pathway (or prereqs, if pathway is false)
  const priorData = computeTransitiveData(lesson, pathway, lessons);

  console.log(
    "pathway is", pathway,
    "lesson is", lesson,
    "pathwayLessons are", pathwayTocs[pathway],
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
    if (prereqs.length < 1) return; // if this is the only lesson, there are no prereqs
    // if a pathway is defined, sort the prereqs in pathway order
    if(pathway) {
      const pathwayLessons = pathwayTocs[pathway];
    }
    // build the row with an empty list
    var tr = document.createElement('tr');
    tr.innerHTML = '<td class="tableblock halign-left valign-top"><div class="content"><div class="paragraph"><p>Prerequisites</p></div></div></td>' +
                   '<td class="tableblock halign-left valign-top"><div class="content"><div class="ulist"><ul></ul></div></div></td>';
    var ul = tr.querySelector('ul');

    // populate the list with each unique prereq
    prereqs.forEach(l => {
      if (!graph[l]) return;
      var li = document.createElement('li');
      li.innerHTML = '<p><a href="../'+l+'/index.shtml?pathway='+pathway+'">'+graph[l].title+'</a></p>';
      ul.appendChild(li);
    })
    // add the row to the table, before "Materials"
    var materialsRow = document.querySelectorAll('table.preamble tr')[2];
    document.querySelector('table.preamble tbody').insertBefore(tr, materialsRow);
  }
}

function togglePageLinks(node, optPages) {
  const grandparent = node.parentNode.parentNode;
  grandparent.classList.toggle("open");
}

// if there's a proglang suffix, remove it
function removeProglangSuffix(lessonName) {
  var lessonTokens = lessonName.split('-');
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
  const dictParent = document.querySelector('table.sidebarstandards tr:last-child .content')
    || document.querySelector('#content');
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

  const dictParent = document.querySelector('table.sidebarstandards tr:last-child .content')
    || document.querySelector('#byAlignment');

  // Can't use querySelector, since some selection values contain dots
  var stdTable = document.getElementsByClassName(selection)[0];

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
  if(!stdTable) throw "ERROR: no standards table exists for " + selection;
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
        return `[<a href="${starterFiles[name][proglang].url}">${fileName.trim()}</a>]`
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
  document.addEventListener('DOMContentLoaded', function () {
    const bodyDivClasses = document.getElementById('body').classList;
    fixStretchTables();
    attachCodeMirror();
    if(!bodyDivClasses.contains("workbookpage")) {
      configureGraph(graph);
      //isNewest();
      attachCollapsible();
      sidebarToggleEvent();
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
