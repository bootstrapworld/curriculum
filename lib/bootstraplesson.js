/*******************************************
 * IDENTIFY OLD VERSIONS
 *******************************************/

 function isNewest() {
   function getUrl(url) {
     xmlhttp = new XMLHttpRequest();
     xmlhttp.onreadystatechange = function () {
       if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
         return xmlhttp.responseText;
       } else {
         return false;
       }
     }
     xmlhttp.open("GET", url, false); /* TODO(Emmanuel): this really should be async */
     xmlhttp.send();
   }

   var currentUrl = window.location.href.toLowerCase();
   var path = currentUrl.split("/");
   if (!(path.includes("latest") && path.includes("lessons"))) {
     path[4] = "latest"; // replace 'seasonYEAR' with 'latest'
     var latestUrl = path.join('/');
     try {
       var latestDoc = getUrl(latestUrl);
       var currentDoc = getUrl(currentUrl);
     } catch (e) {
       // do nothing
     }
     if(!(latestDoc && currentDoc)) {
       console.error("Could not confirm that this is the latest version of this page");
       return;
     } else if (currentDoc !== latestDoc) {
       var outOfDate = document.createElement("div");
       outOfDate.setAttribute("id", "outOfDate");
       outOfDate.innerHTML =
         "These materials are OUT OF DATE! To get the latest version" +
         ' of the materials, visit <a href="https://www.BootstrapWorld.org/materials">' +
         "https://www.BootstrapWorld.org/materials</a>";
       document.body.appendChild(outOfDate);
     }
   }
   console.log("This is the most recent version!");
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
 * BUILD PAGE FROM DEPENDENCY GRAPH
 *******************************************/
function getParams() {
  var params = location.search.substring(1);
  var pathway = !params
    ? false
    : JSON.parse(
        '{"' +
          decodeURI(params)
            .replace(/"/g, '\\"')
            .replace(/&/g, '","')
            .replace(/=/g, '":"') +
          '"}'
      )["pathway"] || false;

  var path = window.location.pathname.split("/");
  var indexOfLessonFolder = path.findIndex(p => p == "lessons");
  var lesson = (indexOfLessonFolder > -1)? 
    path[indexOfLessonFolder + 1] : false;
  return { pathway: pathway, lesson: lesson };
}

// if the lesson isn't in the graph, chop off the -XYZ from the name
// e.g. "simple-data-types-wescheme" becomes "simple-data-types"
// if the lesson cannot be found in the graph, throw an exception
function normalize(l) { 
  if(graph[l]) return l;
  l2 = l.split("-").slice(0,-1).join("-"); // try chopping off lang extension
  if(graph[l2]) return l2;
  else throw l + " is not in the dependency graph!";
}

// used with [].filter to produce an array of unique elts
function onlyUnique(value, index, self) {
  return self.indexOf(value) === index;
}

// Given a page and lesson, produce the relative path name (using .html)
function formatURL(page, lesson) {
  return ("../../lessons/" + lesson + "/pages/" + page).replace("adoc", "html");
}

function computeTransitivePrereqs(lesson) {
  function getPrereqs(l) {
    if (!graph[l]) return [];
    var prereqs = graph[l].prerequisites;
    return prereqs.concat(...prereqs.map(getPrereqs));
  }
  // get the transitive, unique prereqs for this lesson, in order
  graph[lesson].prerequisites = getPrereqs(lesson).reverse().filter(onlyUnique);
  // create a list of (normalized) lessons, from the pathway or the lesson prereqs
  return graph[lesson].prerequisites.concat([lesson]);
}

// Try to load the pathway from the pathway TOC, and obtain prior lessons
// If nothing else, we can compute the lesson list as just the
// prerequisites, plus the lesson itself
function computePriors(lesson, pathway) {
  var normalizedPriors;

  // if we're in standalone mode, recursively compute prereqs
  if(!pathwayTocs || !pathway || !pathwayTocs[pathway]) {
    console.warn("An invalid pathway was declared:'" + pathway
      + "'. This page will be rendered in standalone mode");
    normalizedPriors = computeTransitivePrereqs(lesson);
  // otherwise just grab the pathway lessons, in order
  } else {
    var pathwayLessons = pathwayTocs[pathway].map(normalize);
    var idx = pathwayLessons.indexOf(lesson) + 1;
    normalizedPriors = pathwayLessons.slice(0, idx);
  }

  // if there's only one lesson, there's no priors -> no need to show the sidebar
  var sidebarlessons = document.querySelector('.sidebarlessons');
  if(!pathway) {
    sidebarlessons.style.display = 'none';
  }

  return normalizedPriors;
}

// given an accumulator and a lesson, (1) check if the lesson is in
// the graph, and (2) if it is, process it and add to the accumulator
function processLessonData(acc, l) {
  if(!graph[l]) { 
    console.error('Skipping lesson', l, ': Not in dependency graph!');
    return acc;
  }
  return ({
      titles: acc.titles.concat([l]),
      pages: graph[l].pages.map(p => formatURL(p, l)).concat(acc.pages),
      primitives: graph[l].primitives.concat(acc.primitives),
      prerequisites: graph[l].prerequisites.concat(acc.prerequisites)
    });
}

// process all the prior lessons in reverse order
// seed the prereqs with current lesson prereqs
function computeTransitiveData(lesson, pathway) {
  var priorLessons = computePriors(lesson, pathway);
  return priorLessons.reduceRight(
    processLessonData,
    { titles: [], pages: [], primitives: [], 
      prerequisites: graph[lesson].prerequisites });
}

function addPageNums(priorData) {
  const query = ".PrintableExercise:not(.Optional) a";
  [...document.querySelectorAll(query)].forEach((link) => {
    var path = link.getAttribute("href").split("/");
    path[3] = normalize(path[3]);
    const index = priorData.pages.indexOf(path.join("/"));
    if (index < 0) console.error(`link ${link} does not match a workbook page`);
    link.innerHTML = link.innerHTML + ` (Page ${index + 1})`;
  });
}

function makeLangTable(priorData) {
  if(priorData.primitives.length == 0) {
    return;
  }
  function makeContents(primitives) {
    var types = ["Number", "String", "Boolean", "Image", "Table"];
    var prims = {};
    types.forEach(t => prims[t] = []);
    primitives.forEach(p => {
      if(langTable.Number.primitives.indexOf(p) > -1) {
        prims.Number.push(p);
      } else if(langTable.String.primitives.indexOf(p) > -1) {
        prims.String.push(p);
      } else if(langTable.Boolean.primitives.indexOf(p) > -1) {
        prims.Boolean.push(p);
      } else if(langTable.Image.primitives.indexOf(p) > -1) {
        prims.Image.push(p);
      } else if(langTable.Table.primitives.indexOf(p) > -1) {
        prims.Table.push(p);
      } else {
        throw "Unknown primitive specified:"+p;
      }
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

// use the entire pathway if we have it, otherwise use priors
function buildLessonSidebar(lesson, suffix, pathway, priorData) {
  var lessonList = (pathway && pathwayTocs[pathway].map(normalize))
    || priorData.titles.reverse();
  var sidebarSection = document.getElementsByClassName("sidebarlessons")[0];
  var lessonDOMList = sidebarSection.getElementsByTagName("ul")[0];
  lessonList.forEach((l, i) => {
    if(!graph[l]) { return; } // if it's not in the graph, skip
    var li = document.createElement('li');
    var linkHTML = "<a href='../" + l + suffix + "/index.shtml" 
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

// add all workbook pages into a list. If there's a pathway, group
// them under a bullet first
function workbookPageLinks(pathway) {
  var preamble = document.querySelector('.preamble');
  if(!preamble) return; // this is not a lesson plan - bail

  // Most lessons have a materialSectionPlaceholder. If not, just use the first bullet
  var materialsPlaceholder = document.querySelectorAll('.materialSectionPlaceholder')[0];
  
  if(!pathway) {
    materialsPlaceholder.parentNode.parentNode.remove();
    return;
  }

  // extract the materials list and all required WB pages
  var wbPages = document.querySelectorAll('.PrintableExercise:not(.Optional)');

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

// add " (page X)" to the link title of every PrintableExercise link,
// using the list of pathway lessons and workbook pages specified
// in the dependency graph
function populateLessonFromGraph() {
  if (typeof graph == undefined || !graph) {
    console.error("Dependency graph did not load! This lesson may not render correctly");
    return;
  }

  // delete "phantom" lessons (empty directories left over from
  // switching git branches on a local machine)
  for([k,v] in graph) {
    if(Object.values(v).toString().replaceAll(',','') == "") {
      delete graph[k];
    }
  };
  // get the pathway and lesson name from the URL, compute prior
  // lessons, and aggregate page/prereq/primitive data from priors
  var {pathway, lesson} = getParams();
  if(!lesson) {
    console.log('Not a lesson - will skip populateLessonFromGraph()');
    return;
  }
  var suffix = lesson.replace(normalize(lesson), '');

  if(!pathway || !pathwayTocs[pathway] || !pathwayTocs[pathway].includes(lesson)) {
    pathway = false;
  }
  // get prior data for every lesson in the pathway (or prereqs, if pathway is false)
  var priorData = computeTransitiveData(normalize(lesson), pathway);
  /*
  console.log(
    "pathway is", pathway, 
    "lesson is", normalize(lesson),
    "suffix is", suffix
    "pathwayLessons are", pathwayTocs[pathway], 
    "normalized prior lessons are", priorData.titles,
    "prior data is", priorData);
  */
  // If this is a lesson....
  if(document.body.classList.contains("LessonPlan")){
    // If pathway is defined, add the title
    try {
      if(pathway){ addPathwayTitle(pathway); } 
    } catch (e) { console.log('addPathwayTitle', e); }
    try { 
      workbookPageLinks(pathway); 
    } catch (e) { console.log('workbookPageLinks', e); }
    try { 
      addPageNums(priorData);     
    } catch (e) { console.log('addPageNums', e); }
    try { 
      addPrereqs(lesson, suffix, pathway);  
    } catch (e) { console.log('addPrereqs', e); }
    try { 
      makeLangTable(priorData);   
    } catch (e) { console.log('workbookPageLinks', e); }
    try { 
      buildLessonSidebar(normalize(lesson), suffix, pathway, priorData); 
    } catch (e) { console.log('buildLessonSidebar', e); }
    try {
      if(showStandardsAlignment) showStandardsAlignment();
    } catch (e) { console.log('showStandardsAlignment', e); }
    try {
      if(showTextbooksAlignment) showTextbooksAlignment();
    } catch (e) { console.log('showTextbooksAlignment', e); }
  }
}

function addPrereqs(lesson, suffix, pathway) {
  var prereqs = computeTransitivePrereqs(normalize(lesson));

  if (prereqs.length <= 1) return; // if this is the only lesson, there are no prereqs
  prereqs.pop();                   // pop off the current lesson
  // build the row with an empty list
  var tr = document.createElement('tr');
  tr.innerHTML = '<td class="tableblock halign-left valign-top"><div class="content"><div class="paragraph"><p>Prerequisites</p></div></div></td>' +
                  '<td class="tableblock halign-left valign-top"><div class="content"><div class="ulist"><ul></ul></div></div></td>';
  var ul = tr.querySelector('ul');
  // populate the list with each unique prereq
  prereqs.forEach(l => {
    if (!graph[l]) return;
    var li = document.createElement('li');
    li.innerHTML = '<p><a href="../'+l+suffix+'/index.shtml?pathway='+pathway+'">'+graph[l].title+'</a></p>';
    ul.appendChild(li);
  })
  // add the row to the table, before "Materials"
  var materialsRow = document.querySelectorAll('table.preamble tr')[2];
  document.querySelector('table.preamble tbody').insertBefore(tr, materialsRow);
}

function showLangTable() {
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
 * CODEMIRROR
 *******************************************/

// translate all the TEXTAREA nodes into full-blown CM instances, and color TTs with runmode
// (we use the more expensive CM stuff for indenting)
function attachCodeMirror() {
  var codeSnippets = document.querySelectorAll(
    "code.pyret, code.racket, tt.pyret, tt.racket"
  );
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
}

/*******************************************
 * EVENT HANDLERS
 *******************************************/
window.addEventListener("load", function () {
  isNewest();
  attachCodeMirror();
  sidebarToggleEvent();
  populateLessonFromGraph();
});
