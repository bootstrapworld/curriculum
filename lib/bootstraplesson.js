var langTable = {
  Number: {
    primitives: [
      "+", "-", "*", "/", "expt", "mean", 
      "median", "modes", "sqr", "sqrt"
    ],
    values: ["4", "-1.2", "2/3", "pi"]
  },
  String: {
    primitives: ["string-length", "string-repeat", "string-contains?"],
    values: ['"hello"', '"91"']
  },
  Boolean: {
    primitives: [
      "==", "<", ">", "<>", "<=", ">=", "string-equal",
      "string<?", "string>?", "string=?", "string<>?", 
      "string<=?", "string>=?", "and", "or"
    ],
    values: ["true", "false"]
  },
  Image: {
    primitives: [
      "star", "triangle", "circle", "square", "rectangle", 
      "rhombus", "ellipse", "regular-polygon", "radial-star", 
      "polygon-star", "text", "image-url", "overlay", "put-image", 
      "above", "beside", "below", "rotate", "scale", 
      "flip-horizontal", "flip-vertical", "bar-chart", "pie-chart", 
      "box-plot", "scatter-plot", "lr-plot,", "histogram,", 
      "image-scatter-plot", "bar-chart-summarized", 
      "pie-chart-summarized", "modified-box-plot"
    ],
    values: ["🔵", "🔺", "🔶"]
  },
  Table: {
    primitives: [
      "count", ".row-n", ".order-by", ".filter", 
      ".build-column", "random-rows"
    ],
    values: ["This whole table is a table!"]
  },
}

/*******************************************
 * IDENTIFY OLD VERSIONS
 *******************************************/

function UrlExists(url) {
  var http = new XMLHttpRequest();
  http.open("HEAD", url, false); // TODO: change this to 'true' and use a promise to render the out of date banner
  http.send();
  return http.status !== 404;
}

function isNewest() {
  try {
    // Generate the URL for the *next* version of the curriculum
    var url = window.location.href.toLowerCase();
    var url_year = parseInt(url.match(/(\d{4})\//)[1]);
    var next_url = url.match(/\/spring/i)
      ? url.replace("/spring", "/fall")
      : url.replace(/\/fall\d{4}/, "/spring" + (url_year + 1));

    // If that version exists, throw up a warning
    if (UrlExists(next_url)) {
      var outOfDate = document.createElement("div");
      outOfDate.setAttribute("id", "outOfDate");
      outOfDate.innerHTML =
        "These materials are OUT OF DATE! To get the latest version" +
        ' of the materials, visit <a href="https://www.BootstrapWorld.org/materials">' +
        "https://www.BootstrapWorld.org/materials</a>";
      document.body.appendChild(outOfDate);
    } else {
      console.log(
        "checked for",
        next_url,
        ", and it does not exist. This must be the recent version!"
      );
    }
  } catch (e) {
    console.log(
      "Could not check for newer version. Perhaps you are running locally?"
    );
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
  var lesson = path.splice(-2)[0];
  return { pathway: pathway, lesson: lesson}
}

// if the lesson isn't in the graph, chop off the -XYZ from the name
// e.g. "simple-datatypes-wescheme" becomes "simple-datatypes"
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
  if(!pathwayTocs || !pathway || !pathwayTocs[pathway]) {
    console.warn("Unable to load lesson '" + lesson + " from pathway '"
      + pathway + "'. This lesson will be rendered in standalone mode");
    priorLessons = graph[normalize(lesson)].prerequisites.concat([normalize(lesson)]);
  } else {
    var pathwayLessons = pathwayTocs[pathway];
    var idx = pathwayLessons.indexOf(normalize(lesson)) + 1;
    priorLessons = pathwayLessons.slice(0, idx).map(normalize);
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
      prerequisites: (acc.prerequisites.includes(l)? graph[l].prerequisites : [])
        .concat(acc.prerequisites).filter(onlyUnique)
    });
}

// process all the prior lessons in reverse order
// seed the prereqs with current lesson prereqs
function computeTransitiveData(lesson, pathway) {
  var priorLessons = computePriors(lesson, pathway);
  return priorLessons.reduceRight(
    processLessonData,
    { titles: [], pages: [],primitives: [], 
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
  if(priorData.primitives.length > 0) {
    langTableContents = makeContents(priorData.primitives);
  } else {
    langTableContents = document.createElement('p');
    langTableContents.innerHTML = "Students have not seen any primitives yet!"
  }
  
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
    if(!graph[l]) { return; } // if it's not in the graph, skip
    var li = document.createElement('li');
    var linkHTML = "<a href='../" + lesson + "/index.shtml" 
     + (pathway? "?pathway="+pathway : "")
     + "'>" + graph[l].title + "</a>";
    if(prerequisites.includes(l)) {
      linkHTML = "<span class='prerequisite'>"+linkHTML+"</span>";
    }
    li.innerHTML = linkHTML;
    lessonDOMList.appendChild(li);
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
  var priorData = computeTransitiveData(lesson, pathway);

  console.log(
    "pathway is", pathway, 
    "lesson is", lesson,
    "pathwayLessons are", pathwayTocs[pathway], 
    "normalized prior lessons are", priorData.titles,
    "prior data is", priorData);

  addPageNums(priorData);
  makeLangTable(priorData);
  buildLessonSidebar(lesson, pathway, priorData);
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
  populateLessonFromGraph();
  isNewest();
  attachCodeMirror();
  showStandardsAlignment();
  showTextbooksAlignment();
});
