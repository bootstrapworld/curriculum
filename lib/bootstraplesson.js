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
    ? "none"
    : JSON.parse(
        '{"' +
          decodeURI(params)
            .replace(/"/g, '\\"')
            .replace(/&/g, '","')
            .replace(/=/g, '":"') +
          '"}'
      )["pathway"] || "none";

  var path = window.location.pathname.split("/");
  var lesson = path.splice(-2)[0];
  return { pathway: pathway, lesson: lesson}
}

var normalize; // global to track whether had to drop a lang extension

// chop off the last -XYZ from a lesson name
// e.g. "simple-datatypes-wescheme" becomes "simple-datatypes"
const normalizeLesson = (l) => l.split("-").slice(0,-1).join("-");

// add " (page X)" to the link title of every PrintableExercise link,
// using the list of pathway lessons and workbook pages specified
// in the dependency graph
function computeFromGraph() {
  if (!graph) {
    console.error("Dependency graph did not load! This lesson may not render correctly");
    return;
  }
  // get the pathway and lesson name from the URL
  // check to see if we need to normalize lesson names
  var {pathway, lesson} = getParams(), normalizedLesson;
  var priorLessons, graphPriors;

  // See if the lesson is valid (and set normalization values)
  if(graph[lesson]) {
    normalize = false;
    normalizedLesson =  lesson;
  } else if(graph[normalizeLesson(lesson)]) { 
    normalize = true;
    normalizedLesson = normalizeLesson(lesson);
  } else {
    console.error("The lesson '"+lesson+"' is not recognized as part of the dependency graph.")
    return;
  }

  // We have a valid lesson! If nothing else, we can compute the prior
  // lessons as just the prerequisites, plus the lesson itself
  normalizedPriors = graph[normalizedLesson].prerequisites.concat([normalizedLesson]);

  // Try to load the pathway from the pathway TOC, and obtain prior lessons
  if(!pathwayTocs || !pathway || !pathwayTocs[pathway]) {
    console.warn("Unable to load lesson '" + lesson + " from pathway '"
      + pathway + "'. This lesson will be rendered in standalone mode");
  } else {
    var pathwayLessons = pathwayTocs[pathway];
    var idx = pathwayLessons.indexOf(lesson) + 1;
    normalizedPriors = pathwayLessons.splice(0, idx).map(normalizeLesson);
  }

  console.log("pathway is", pathway, "lesson is", lesson,
    "pathwayLessons are", pathwayLessons, 
    "normalized prior lessons are", normalizedPriors);

  // Given a page and lesson, produce the relative path name
  const formatURL = (page, lesson) =>
    ("../../lessons/" + lesson + "/pages/" + page).replace("adoc", "html");

  // process all the prior pages and primitives (in order)
  var priorData = normalizedPriors.reduce(
    (acc, l) => ({
      pages: acc.pages.concat(graph[l].pages.map(p => formatURL(p, l))),
      primitives: acc.primitives.concat(graph[l].primitives),
    }),
    { pages: [], primitives: [] }
  );

  // Assign page numbers to WB page links
  addPageNums(priorData.pages, normalize);

  buildLessonSidebar(lesson, normalizedPriors, pathway);
}

function addPageNums(pages, normalize) {
  const query = ".PrintableExercise:not(.Optional) a";
  [...document.querySelectorAll(query)].forEach((link) => {
    var path = link.getAttribute("href").split("/");
    if(normalize){  // adjust the path if we need to normalize
      path[3] = normalizeLesson(path[3]);
    }
    const index = pages.indexOf(path.join("/"));
    if (index < 0) console.error(`link ${link} does not match a workbook page`);
    link.innerHTML = link.innerHTML + ` (Page ${index + 1})`;
  });
}

function makeLangTable(primitives) {
  // construct the language table, then embed it in a preamble row
  var langTableContents;
  if(primitives.length > 0) {
    langTableContents = makeLangTable(primitives);
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
  preamble.querySelector('tbody').appendChild(langTableRow);  var types = ["Number", "String", "Boolean", "Image", "Table"];
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

function buildLessonSidebar(lesson, normalizedPriors, pathway) {
  var prerequisites = graph[normalizedPriors.pop()].prerequisites;
  var sidebarSection = document.getElementsByClassName("sidebarlessons")[0];
  var lessonList = sidebarSection.getElementsByTagName("ul")[0];
  normalizedPriors.forEach((l, i) => {
    var fullLessonName = (normalize? l + "-" + lesson.split("-").slice(-1) : l);
    var li = document.createElement('li');
    var linkHTML = "<a href='../" + fullLessonName + "/index.shtml?pathway="+pathway+"'>"
      + graph[l].title + "</a>";
    if(prerequisites.includes(l)) {
      linkHTML = "<span class='prerequisite'>"+linkHTML+"</span>";
    }
    li.innerHTML = linkHTML;
    lessonList.appendChild(li);
  });
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
  computeFromGraph();
  isNewest();
  attachCodeMirror();
  showStandardsAlignment();
  showTextbooksAlignment();
});
