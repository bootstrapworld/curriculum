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
  try{
    // Generate the URL for the *next* version of the curriculum
    var url = window.location.href.toLowerCase();
    var url_year = parseInt(url.match(/(\d{4})\//)[1]);
    var release = url.slice(0, url.indexOf(url_year) + 4);

    var next_release = (release.match(/\/spring/i))? release.replace("/spring", "/fall") 
      : release.replace(/\/fall\d{4}/, "/spring" + (url_year+1));

    // If that version exists, throw up a warning
    if(UrlExists(next_release)){
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
  var sections = document.querySelectorAll(".LessonPlan h2, .TeacherResources .sect1 h2");

  sections.forEach(function(section){
    section.addEventListener("click", function() {
      this.classList.toggle("active");
      var content = this.nextElementSibling;
      if (content.style.maxHeight){
        content.style.maxHeight = null;
      } else {
        content.style.maxHeight = "100%";
      } 
    });
  });
}


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
  var tables = document.querySelectorAll('body.workbookpage table.FillVerticalSpace');
  tables.forEach (t => {
    if(!t.querySelector('thead')) t.style.gridTemplateRows = 'auto';
    var cols = [...t.querySelector('colgroup').children];
    t.style.gridTemplateColumns = cols.map(c => c.style.width).join(" ")
  });
}

/*******************************************
 * BUILD PAGE FROM DEPENDENCY GRAPH
 * Everything south of here relies on the dependency graph!
 * Chnages to the graph will require changes to most of this code
 *******************************************/
const proglangs = "wescheme pyret codap spreadsheets none".split(new RegExp(" \+"));

function getParams() {
  const url = new URL(location);
  var {pathway, lessons, solns} = Object.fromEntries([...url.searchParams.entries()]);
  if(lessons)  lessons = lessons.split(",");
  if(!solns)   solns = false;

  // if a custom pathway is defined with lessons, do some verification
  if(pathway && lessons && lessons.length > 0) { 
    if(lessons.some(l => !graph[l])) {
      console.error('At least one lesson in this custom pathway is unknown'); 
      pathway = lessons = false; // render in standalone mode
    }
  }
  // if we're using a built-in pathway, use *those* lessons
  else if(pathway && pathwayTocs && pathwayTocs[pathway]) {
    lessons = pathwayTocs[pathway]; // use the lessons in this pathway
    console.log('setting lessons to', lessons.join(','))
  }

  var path = window.location.pathname.split("/");
  var indexOfLessonFolder = path.findIndex(p => p == "lessons");
  var lesson = (indexOfLessonFolder > -1)? path[indexOfLessonFolder + 1] : false;
  console.log(
          "pathway is", pathway, 
          "lesson is", lesson,
          "lessons are",lessons)
  return { pathway: pathway, lessons: lessons, lesson: lesson, solns: solns };
}

const getTransitivePrereqs = (l) => {
    if(!graph[l]) {
        throw "an unknown lesson was passed to getTransitivePrereqs:" + l;
    }
    var prereqs = graph[l].prerequisites || [];
    return prereqs.concat(...prereqs.map(getTransitivePrereqs));
}

// used with [].filter to produce an array of unique elts
const onlyUnique = (value, index, self) => self.indexOf(value) === index;

function configureGraph(graph) {
    // remove lessons that don't belong in the graph
    const lessonsToIgnore = ['__sample-lesson','__sample-lesson-wescheme', 'zample-lesson', 'hoc-wescheme-intro', 'hoc-winter', 'hoc-winter-parley', '__sample-lesson-codap', 
        'dot-plots-bar-charts', 
        'codap-exploring', 
        'codap-filtering', 
        'codap-building', 
        'codap-composing',
        'computing-needs-all-voices-codap', 
        'ethics-privacy-and-bias-codap', 
        'grouped-samples-codap', 
        'project-data-exploration-codap', 
        'sw-what-ships-carried-spreadsheets', 
        'sw-where-in-asia-spreadsheets',
        'exploring-linear-relationships',
        'exploring-quadratic-relationships',
        'exploring-logarithmic-relationships',
        'maya-skulls-spreadsheets', 
        'maya-1-spreadsheets'];
    lessonsToIgnore.forEach(l => delete graph[l]);

    // add projects to the graph
    var projects = [
        {
            title: 'Make an Infographic',
            path: 'bar-and-pie-charts/pages/infographic.html',
            prerequisites: ['bar-and-pie-charts'],
            description: 'Infographics are a powerful tool for communicating information, especially when made by people who actually understand how to connect visuals to data in meaningful ways. This project is an opportunity for students to become more flexible math thinkers while tapping into their creativity, and can be made on the computer or with pencil and paper.',
        },
        {
            title: 'Draw a Flag',
            path: 'flags/',
            prerequisites: ['flags'],
            description: 'Students recreate images of flags of varying complexity by transforming and composing image functions and applying their knowledge of ratios and coordinates to scale and position the shapes precisely.',
        },
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
            path: 'box-plots/pages/stress-project.html',
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
        p.starterFiles = [];
        p. primitives = [];
        p.glossary = [];
        p.pages = [];
     });

    // recursively compute all prerequisites for each lesson and project
    Object.keys(graph).forEach(k =>
        graph[k].prerequisites = getTransitivePrereqs(k).filter(onlyUnique));
}

// process all the prior lessons in reverse order
// seed the prereqs with current lesson prereqs
function computeTransitiveData(lesson, pathway, lessons = false) {
  // Given a page and lesson, produce the relative path name (using .html)
  function formatPageURL(page, lesson) {
    return ("../../lessons/" + lesson + "/pages/" + page).replace("adoc", "html");
  }

  var priorLessons;
  // If we're looking at a lesson from a pathway
  if(lesson && lessons) {
    priorLessons = lessons.slice(0, lessons.indexOf(lesson) + 1);
  // If we're looking at a list of lessons
  } else if(!lesson && lessons) {
    priorLessons = lessons;
  } else {
    console.warn("Could not find a valid lesson list. Rendering page in standalone mode");
    // Build the transitive prereqs for this lesson - in order - and add lesson
    priorLessons = getTransitivePrereqs(lesson).reverse().concat([lesson]);
  }

  // given an accumulator and a lesson, (1) check if the lesson is in
  // the graph, and (2) if it is, process it and add to the accumulator
  function processLessonData(acc, l) {
    if(!graph[l]) { 
      console.error('Skipping lesson', l, ': Not in dependency graph!', acc);
    }
    let glossary = acc.glossary;
    graph[l].glossary.forEach(({vocab, description}) => glossary.set(vocab, description));

    return ({
        titles: acc.titles.concat([l]).filter(onlyUnique),
        pages: graph[l].pages.map(p => formatPageURL(p, l)).concat(acc.pages),
        primitives: graph[l].primitives.concat(acc.primitives).filter(onlyUnique),
        prerequisites: graph[l].prerequisites.concat(acc.prerequisites).filter(onlyUnique),
        starterFiles: graph[l].starterFiles.concat(acc.starterFiles).filter(onlyUnique),
        glossary: glossary
      });
  }

  // Return the prior data for all lessons up to and including this one
  return priorLessons.reduceRight(
    processLessonData,
    { titles: [], pages: [], primitives: [], 
      prerequisites: [], starterFiles: [], glossary: new Map() });
}

// Based on the dependency graph, customize the lesson plan
// 1. add page numbers to PrintableExercise links
// 2. populate the list of prerequisite lessons
// 3. populate the language table
// using the list of pathway lessons and workbook pages specified
// in the dependency graph
function populateLesson() {

  function addPageNums(priorData) {
    const query = ".PrintableExercise:not(.Optional)";
    [...document.querySelectorAll(query)].forEach((span) => {
      link = span.querySelector("a");
      var path = link.getAttribute("href").split("/");
      const index = priorData.pages.indexOf(path.join("/"));
      if (index < 0) console.error(`link ${link} does not match a workbook page`);
      span.innerHTML += ` (Page ${index + 1})`;
    });
  }

  function makeLangTable(priorData) {
    // if there aren't any primitives, don't show the langTable link at all
    if(priorData.primitives.length == 0) {
      console.log('no prior primitives defined - hiding langTable link');
      [...document.querySelectorAll('.materials-links li')].pop().remove();
      return;
    }
    function makeContents(primitives) {
      var types = ["Number", "String", "Boolean", "Image", "Table"];
      var prims = {};
      types.forEach(t => prims[t] = []);
      primitives.forEach(p => {
        for(type of types) {
          if(langTable[type].primitives.find(prim => prim.name == p)) {
            prims[type].push(p);
            return;
          }
        };
        if(!prims[type][p]) { throw "Unknown primitive specified:"+p; }
      });

      var t = document.createElement("table");
      t.id = 'LanguageTable';
      t.className = "tableblock frame-all grid-all stretch lang-features-table";
      t.innerHTML='<colgroup><col style="width:14%;"><col style="width:57%;"><col style="width:29%;"></colgroup>';
      var tbody = document.createElement("tbody");
      // Make the header row
      tbody.innerHTML = ["Types", "Functions", "Values"].map(type => 
        '<td class="tableblock halign-center">'+type+'</td>').join("");
      // For each type, add a row
      types.forEach(type => {
        if(prims[type].length == 0) return;
        var row = document.createElement("tr");
        row.innerHTML = '<td class="tableblock"><p>'+type+'</p></td>' +
        '<td class="tableblock halign-center">' + prims[type].map(p => 
          '<tt class="pyret">'+p+'</tt>').join(", ") + '</td>' +
        '<td class="tableblock halign-center">' + langTable[type].values.map(v => 
            '<tt class="pyret">'+v+'</tt>').join() + '</td>';
        tbody.appendChild(row);
      });
      t.style.display = 'none';
      t.appendChild(tbody);
      return t;
    }
    var langTableContents;
    langTableContents = makeContents(priorData.primitives);
    document.body.appendChild(langTableContents);
  }

  // use the entire pathway or custom lesson list (if we have it)
  // otherwise use sorted prereqs
  function buildLessonSidebar(lesson, pathway, priorData) {
    var lessonList = (pathway && pathwayTocs[pathway]) || lessons;
    if(!lessonList) {
      lessonList = priorData.titles
        .reverse()
        .sort((a,b) =>
          (graph[a].prerequisites.length < graph[b].prerequisites.length)? -1 : 1);
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
  }

  // Put pathway name in lessons title
  function addPathwayTitle(pathway) {
    var words = pathway.split('-');
    words = words.map(w => w.toLowerCase());
    words = words.map(w => w.charAt(0).toUpperCase() + w.slice(1));
    pathway = words.join(" ");
    var title = document.querySelector('.sidebarlessons strong');
    if(!title) { console.error('EXCEPTION: no lesson title was found'); }
    else { title.innerHTML = pathway + " Lessons"; }
  }

  // if there's no pathway defined, hide all pathway-only content
  function checkPathwayOnly(pathway) {
    const nodes = [...document.querySelectorAll('.pathway-only')];
    nodes.forEach(n => {
      if(!pathway){ n.style.display = 'none'; }
    });
  }
  
  // add all workbook pages into a list. If there's a pathway, group
  // them under a bullet first
  function workbookPageLinks(pathway) {
    // Extract the materials list and all required WB pages
    var wbPages = document.querySelectorAll('.PrintableExercise:not(.Optional)');

    // Most lessons have a materialSectionPlaceholder. If not, our work here is done
    var materialsPlaceholder = document.querySelectorAll('.materialSectionPlaceholder')[0];
    if(!materialsPlaceholder) return;

    // if no pathway or wbpages are defined, remove the placeholder
    if(!pathway || !wbPages.length) {
      materialsPlaceholder.parentNode.parentNode.remove();
      return;
    }

    // build the WB link
    var path = "../../courses/"+pathway+"/workbook/workbook.pdf";
    var link = document.createElement('a');
    link.setAttribute('href', path);
    link.innerHTML = 'Student Workbook:';

    // grab each wbPage grandparent (LIs), and put them under wbList
    var wbList = document.createElement('ul');
    wbPages.forEach(span => wbList.appendChild(span.parentNode.parentNode));

    // make the new, top-level LI node, and add the workbook link and pages list
    var LI = document.createElement('li');
    LI.innerHTML = "Pages from the "
    LI.appendChild(link);
    LI.appendChild(wbList);
    materialsPlaceholder.parentNode.replaceChild(LI, materialsPlaceholder);
  }

  // if there's no graph, log to the console and hide the placeholder
  if ((typeof graph == "undefined") || !graph) {
    console.error("Dependency graph did not load! This lesson may not render correctly");
    document.querySelectorAll('.materialSectionPlaceholder').forEach( n =>
      n.parentNode.parentNode.remove());
    return;
  }

  // delete "phantom" lessons (empty directories left over from
  // switching git branches on a local machine)
  for(var [k,v] in graph) {
    if(Object.values(v).toString().replaceAll(',','') == "") {
      delete graph[k];
    }
  };

  // get the pathway, lessons names and current lesson from the URL
  var {pathway, lessons, lesson} = getParams();
  if(!lesson) {
    console.log('Not a lesson - will skip populateLessonFromGraph()');
    return;
  }

  if(!pathway || !pathwayTocs[pathway] || !pathwayTocs[pathway].includes(lesson)) {
    pathway = false;
  }
  // get prior data for every lesson in the pathway (or prereqs, if pathway is false)
  var priorData = computeTransitiveData(lesson, pathway, lessons);
  
  console.log(
    "pathway is", pathway, 
    "lesson is", lesson,
    "pathwayLessons are", pathwayTocs[pathway], 
    "prior lessons are", priorData.titles,
    "prior data is", priorData);
  
  // If pathway is defined, add the title
  try {
    console.log('PATHWAY IS', pathway)
    if(pathway) { addPathwayTitle(pathway); } 
    checkPathwayOnly(pathway);    // Also hide any pathway-only content
  } catch (e) { console.log('addPathwayTitle', e); }
  try { 
    workbookPageLinks(pathway);
  } catch (e) { console.log('workbookPageLinks', e); }
  try { 
    addPageNums(priorData);     
  } catch (e) { console.log('addPageNums', e); }
  try { 
    // only compute prereqs for the currently-active lesson
    addPrereqs(computeTransitiveData(lesson, false, false).prerequisites);  
  } catch (e) { console.log('addPrereqs', e); }
  try { 
    buildLessonSidebar(lesson, pathway, priorData); 
  } catch (e) { console.log('buildLessonSidebar', e); }
  try {
    populateAlignmentDictionaries("lesson");
    showAlignment('standards-CCSS-Math');
  } catch (e) { console.log('adding Alignments', e); }
  // if it's wescheme or pyret, build the languageTable
  if(document.body.classList.contains('pyret') || document.body.classList.contains('wescheme')){
    try { 
      makeLangTable(priorData);   
    } catch (e) { console.log('makeLangTable', e); }
  }

  function addPrereqs(prereqs) {
    if (prereqs.length < 1) return; // if this is the only lesson, there are no prereqs
    // if a pathway is defined, sort the prereqs in pathway order
    if(pathway) {
      const pathwayLessons = pathwayTocs[pathway];
      prereqs.sort((a,b) =>
        (pathwayLessons.indexOf(a) < pathwayLessons.indexOf(b))? -1 : 1);
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

// if there's a proglang suffix, remove it
function removeProglangSuffix(lessonName) {
  var lessonTokens = lessonName.split('-');
  const lastToken = lessonTokens.pop();
  return proglangs.includes(lastToken)? lessonTokens.join('-') : lessonName;
}

function showLangTable() {
  if(!document.getElementById('LanguageTable')) return;
  document.getElementById('body').style.opacity = 0.5;
  document.getElementById('LanguageTable').style.display = 'table';
  document.body.addEventListener("click", hideLangTable);
}

function hideLangTable() {
  document.getElementById('body').style.opacity = 1;
  document.getElementById('LanguageTable').style.display = 'none';
  document.body.removeEventListener("click", hideLangTable);
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
  "SD", "TN", "UT", "VT", "WA", "WV", "WI", "WY"];

const cstaStates = [
  "AK", "CT", "DE", "HI", "IA", "ID", "IL", "MD", "MI", "MS", "NH",
  "NM", "PA", "OR", "WA"];  

function populateAlignmentDictionaries(alignedTo) {
  const { lesson, pathway, lessons } = getParams();
  let alignedLessons;

  if(alignedTo == "lesson") { alignedLessons = [lesson] }
  else if(lessons) { alignedLessons = lessons; }
  else { alignedLessons = Object.keys(graph); }

  const normalizedAlignedLessons = alignedLessons.map(removeProglangSuffix);

  // get DOM for alignment parent and alignment dropdown menu
  const dictParent = document.querySelector('table.sidebarstandards tr:last-child .content')
    || document.querySelector('#content');
  const dropdown = document.getElementsByClassName('alignmentSelect')[0];
  const url = new URL(location);

  // add a group of standards to the page
  function addGroup(keyName, groupLabel) {
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
        <h2><a href="`+stdUrl+`">`+fullname+`</a></h2>
      </div><dl></dl>`;
      const list = div.querySelector('dl')

      // Walk over entries, adding each to the list if it aligns with the current lesson
      // OR if there's a lesson in the current pathway or graph that aligns to it
      // SKIP __metadata, which does not contain a 'lessons' field
      for( const [id, std] of Object.entries(stds) ) {
        if(std.lessons && std.lessons.filter(l => normalizedAlignedLessons.includes(l)).length) {
          const dt = document.createElement('dt');
          dt.innerHTML = id;
          const dd = document.createElement('dd');
          // if it's a pathway alignment page and there are standards,
          // add all lessons (and links!) to the description
          if(!lesson) {
            var relevantLessons = alignedLessons.filter(l => std.lessons.includes(removeProglangSuffix(l)));
            // if we're not aligned to any specific pathway or lesson, remove suffixed duplicates
            if(!alignedTo) { relevantLessons = relevantLessons.filter(l => removeProglangSuffix(l) == l) };
            std.description += " [See: ";
            std.description += relevantLessons.map(l =>
                "<a href='lessons/" + l + "/index.shtml" + url.search + "''>"
                + graph[l].title + "</a>").join(", ");
            std.description += "]";
          }
          dd.innerHTML = "<p>"+std.description+"</p>";
          list.appendChild(dt);
          list.appendChild(dd);
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
    console.log(source, dest)
    const stds = document.querySelector(source+' dl');
    if(!stds) return; // if the table doesn't exist, skip
    [...stds.children].forEach(n => dest.appendChild(n.cloneNode(true)));
  }

  const dictParent = document.querySelector('table.sidebarstandards tr:last-child .content')
    || document.querySelector('#content'); 

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
  const container = document.querySelectorAll('.starterFileList')[0];
  const ul = document.createElement("ul");
  const data = computeTransitiveData(lesson, pathway, lessons);
  const proglang = graph[lessons[0]].proglang;
  //make links for every file, ignoring editor and program-list
  data.starterFiles
    .filter(name => !["editor", "program-list"].includes(name))
    .forEach(name => {
    const li = document.createElement("li");
    li.innerHTML = '<a href="' + starterFiles[name][proglang].url + '">' +
      starterFiles[name].title + '</a>';
    ul.appendChild(li);
  });
  container.appendChild(ul);
}


/*******************************************
 * EVENT HANDLERS
 *******************************************/
// if we're in a browser, attach event handlers
if(typeof document !== 'undefined') {
  document.addEventListener('DOMContentLoaded', function () {
    isNewest();
    attachCodeMirror();
    attachCollapsible();
    sidebarToggleEvent();
    if(document.body.classList.contains("TeacherResources")) { populateTeacherResources(); }
    if(document.body.classList.contains("LessonPlan")) { populateLesson(); }
    if(location.href.includes('Alignments.shtml')) { populatePathwayAlignment(); }
    fixStretchTables();
  });
}

// if we're in node, provide the module exports
if(typeof module !== 'undefined'){
  module.exports = {
    configureGraph: configureGraph,
  };
}