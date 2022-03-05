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
  var indexOfLessonFolder = path.slice(-3).findIndex(p => p == "lessons");
  var lesson = (indexOfLessonFolder > -1)? 
    path.slice(-3)[indexOfLessonFolder + 1] : false;
  return { pathway: pathway, lesson: lesson };
}

// if the lesson isn't in the graph, chop off the -XYZ from the name
// e.g. "simple-data-types-wescheme" becomes "simple-data-types"
// if the lesson cannot be found in the graph, throw an exception
function normalize(l) { 
  if(graph[l]) return l;
  l = l.split("-").slice(0,-1).join("-"); // try chopping off lang extension
  if(graph[l]) return l;
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

// Try to load the pathway from the pathway TOC, and obtain prior lessons
// If nothing else, we can compute the lesson list as just the
// prerequisites, plus the lesson itself
function computePriors(lesson, pathway) {
  var priorLessons;
  const normalized = normalize(lesson);
  const getPrereqs = (l) => {
    const prereqs = graph[normalize(l)].prerequisites;
    return prereqs.concat(...prereqs.map(getPrereqs));
  }
  // set the transitive prereqs for this lesson
  graph[normalized].prerequisites = getPrereqs(lesson)
    .reverse()
    .filter(onlyUnique);
  if(!pathwayTocs || !pathway || !pathwayTocs[pathway]) {
    console.warn(lesson + " not associated with pathway '" + pathway
      + "'. This lesson will be rendered in standalone mode");
    priorLessons = graph[normalized].prerequisites.concat([normalized]);
  } else {
    var pathwayLessons = pathwayTocs[pathway];
    var idx = pathwayLessons.indexOf(lesson) + 1;
    priorLessons = pathwayLessons.slice(0, idx).map(normalize);
  }
  if(priorLessons.length == 0) {
    document.querySelector('.sidebarlessons').style.display = 'none';
  }
  return priorLessons;
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
      prerequisites: graph[l].prerequisites
    });
}

// process all the prior lessons in reverse order
// seed the prereqs with current lesson prereqs
function computeTransitiveData(lesson, pathway) {
  var priorLessons = computePriors(lesson, pathway);
  return priorLessons.reduceRight(
    processLessonData,
    { titles: [], pages: [], primitives: [], 
      prerequisites: graph[normalize(lesson)].prerequisites });
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
    t.className = "tableblock frame-all grid-all stretch lang-features-table";
    t.innerHTML='<colgroup><col style="width:14%;"><col style="width:57%;"><col style="width:29%;"></colgroup>';
    var tbody = document.createElement("tbody");
    // Make the header row
    tbody.innerHTML = ["Types", "Functions", "Values"].map(type => 
      '<td class="tableblock">'+type+'</td>').join("");
    // For each type, add a row
    types.forEach(type => {
      if(prims[type].length == 0) return;
      var row = document.createElement("tr");
      row.innerHTML = '<td class="tableblock"><p>'+type+'</p></td>' +
      '<td class="tableblock">' + prims[type].map(p => 
        '<tt class="pyret">'+p+'</tt>').join(", ") + '</td>' +
      '<td class="tableblock">' + langTable[type].values.map(v => 
          '<tt class="pyret">'+v+'</tt>').join() + '</td>';
      tbody.appendChild(row);
    });
    t.appendChild(tbody);
    return t;
  }
  var langTableContents;
  langTableContents = makeContents(priorData.primitives);
  
  var preamble = document.getElementsByClassName("preamble")[0];
  var langTableRow = document.createElement("tr");
  var langTableCell = document.createElement("td");
  langTableRow.innerHTML = '<td><p>Language Table</p></td>';
  langTableRow.appendChild(langTableCell);
  langTableCell.appendChild(langTableContents);
  preamble.querySelector('tbody').appendChild(langTableRow);
}

// use the entire pathway if we have it, otherwise use priors
function buildLessonSidebar(lesson, pathway, priorData) {
  var lessonList = pathwayTocs[pathway] || priorData.titles.reverse();
  var prerequisites = graph[normalize(lesson)].prerequisites;
  var sidebarSection = document.getElementsByClassName("sidebarlessons")[0];
  var lessonDOMList = sidebarSection.getElementsByTagName("ul")[0];
  lessonList.forEach((l, i) => {
    normalized = normalize(l);
    if(!graph[normalized]) { return; } // if it's not in the graph, skip
    var li = document.createElement('li');
    var linkHTML = "<a href='../" + l + "/index.shtml" 
     + (pathway? "?pathway="+pathway : "")
     + "'>" + graph[normalized].title + "</a>";
    if(prerequisites.includes(normalized)) {
      linkHTML = "<span class='prerequisite'>"+linkHTML+"</span>";
    }
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

// if a pathway is defined, adjust the link
// if not, *remove* the link
function pathwayWorkbookLink(pathway) {
  pathwayLinks = [...document.querySelectorAll('.pathway-link')]
    .map(l => l.firstChild)
    .forEach((l) => {
      if(pathway) {
        l.setAttribute("href", "../../courses/"+pathway+"/"+l.getAttribute("href"));
      } else {
        var li = l.parentNode.parentNode.parentNode;
        li.parentNode.removeChild(li);
      }
    });
}

// add " (page X)" to the link title of every PrintableExercise link,
// using the list of pathway lessons and workbook pages specified
// in the dependency graph
function populateLessonFromGraph() {
  if (!graph) {
    console.error("Dependency graph did not load! This lesson may not render correctly");
    return;
  }
  // get the pathway and lesson name from the URL, compute prior
  // lessons, and aggregate page/prereq/primitive data from priors
  var {pathway, lesson} = getParams();
  if(!lesson) {
    console.log('Not a lesson - will skip populateLessonFromGraph()');
    return;
  }

  if(!pathway || !pathwayTocs[pathway] || !pathwayTocs[pathway].includes(lesson)) {
    pathway = false;
  }

  var priorData = computeTransitiveData(lesson, pathway);
  /*
  console.log(
    "pathway is", pathway, 
    "lesson is", lesson,
    "pathwayLessons are", pathwayTocs[pathway], 
    "normalized prior lessons are", priorData.titles,
    "prior data is", priorData);
  */

  if(pathway) addPathwayTitle(pathway);
  pathwayWorkbookLink(pathway);
  addPageNums(priorData);
  makeLangTable(priorData);
  buildLessonSidebar(lesson, pathway, priorData);
  if(showStandardsAlignment) showStandardsAlignment();
  if(showTextbooksAlignment) showTextbooksAlignment();
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
