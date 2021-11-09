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

// add " (page X)" to the link title of every PrintableExercise link,
// using the list of pathway lessons and workbook pages specified
// in the dependency graph
function computeFromPathway() {
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
  var pathwayLessons = pathwayTocs[pathway];

  console.log("pathway is", pathway);
  console.log("pathwayLessons are", pathwayLessons);
  console.log("lesson is", lesson);

  if (!pathwayLessons || !graph) {
    console.warn("pathwayLessons is not defined. Rendering lesson in standalone mode.");
    return;
  }

  // compute data for all prior lessons...plus this one
  var idx = pathwayLessons.indexOf(lesson) + 1;
  var priorLessons = pathwayLessons.splice(0, idx);

  // process all the prior pages and primitives (in order)
  var priorData = priorLessons.reduce(
    (acc, l) => ({
      pages: acc.pages.concat(
        graph[l].pages.map((p) =>
          ("../../lessons/" + l + "/pages/" + p).replace("adoc", "html")
        )
      ),
      primitives: acc.primitives.concat(graph[l].primitives),
    }),
    { pages: [], primitives: [] }
  );

  // Assign page numbers to WB page links
  addPageNums(priorData.pages);

  // construct the language table, then embed it in a preamble row
  var langTableContents;
  if(priorData.primitives.length > 0) {
    langTableContents = makeLangTable(priorData.primitives);
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

function addPageNums(pages) {
  const query = ".PrintableExercise:not(.Optional) a";
  [...document.querySelectorAll(query)].forEach((l) => {
    const index = pages.indexOf(l.getAttribute("href"));
    if (index < 0) console.error(`link ${l} does not match a workbook page`);
    l.innerHTML = l.innerHTML + ` (Page ${index + 1})`;
  });

}

function makeLangTable(primitives) {
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
  computeFromPathway();
  isNewest();
  attachCodeMirror();
  showStandardsAlignment();
  showTextbooksAlignment();
});
