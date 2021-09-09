// For ancient browsers that don't support .forEach()
(function(){Array.prototype.forEach||(Array.prototype.forEach=function(n,t){var u,i,r,f,e;if(this==null)throw new TypeError(" this is null or not defined");if(r=Object(this),f=r.length>>>0,typeof n!="function")throw new TypeError(n+" is not a function");for(arguments.length>1&&(u=t),i=0;i<f;)i in r&&(e=r[i],n.call(u,e,i,r)),i++})})();



/*******************************************
 * IDENTIFY OLD VERSIONS
 *******************************************/

function UrlExists(url) {
    var http = new XMLHttpRequest();
    http.open('HEAD', url, false); // TODO: change this to 'true' and use a promise to render the out of date banner
    http.send();
    return (http.status !== 404)
}

function isNewest() {
  try{
    // Generate the URL for the *next* version of the curriculum
    var url = window.location.href.toLowerCase();
    var url_year = parseInt(url.match(/(\d{4})\//)[1]);
    var next_url = (url.match(/\/spring/i))? url.replace("/spring", "/fall") 
      : url.replace(/\/fall\d{4}/, "/spring" + (url_year+1));

    // If that version exists, throw up a warning
    if(UrlExists(next_url)){
      var outOfDate = document.createElement('div');
      outOfDate.setAttribute('id', 'outOfDate');
      outOfDate.innerHTML = 'These materials are OUT OF DATE! To get the latest version'
        + ' of the materials, visit <a href="https://www.BootstrapWorld.org/materials">'
        + 'https://www.BootstrapWorld.org/materials</a>';
      document.body.appendChild(outOfDate);
    } else {
      console.log("checked for",next_url,", and it does not exist. This must be the recent version!");
    }
  } catch(e) {
    console.log("Could not check for newer version. Perhaps you are running locally?");
  }
}

// add " (page X)" to the link title of every PrintableExercise link,
// using the list of pathway lessons and workbook pages specified
// in the dependency graph
function computePageNums() {
  if(!pathwayLessons) console.error('pathwayLessons is not defined');
  if(!graph) console.error('dependency graph is not defined');
  const pages = pathwayLessons.map(l => graph[l].pages.map(p => 
      ("../../lessons/"+l+"/pages/"+p).replace("adoc", "html")))
    .flat();
  // we want all required, printable links 
  const query = ".PrintableExercise:not(.Optional) a";
  [...document.querySelectorAll(query)].forEach(l => {
    const index = pages.indexOf(l.getAttribute('href'));
    if(index < 0) console.error(`link ${l} does not match a workbook page`);
    l.innerHTML = l.innerHTML + ` (Page ${index + 1})`
  });
}

/*******************************************
 * CODEMIRROR
 *******************************************/

// translate all the TEXTAREA nodes into full-blown CM instances, and color TTs with runmode
// (we use the more expensive CM stuff for indenting)
function attachCodeMirror(){
  var codeSnippets = document.querySelectorAll("code.pyret, code.racket, tt.pyret, tt.racket");
  codeSnippets.forEach(function(tt, idx){
      var node = document.createElement('span');
      node.className = 'editbox';
      tt.parentNode.insertBefore(node, tt);
      if(tt.className == "racket" && tt.firstChild){
        CodeMirror.runMode(tt.firstChild.nodeValue, "scheme2", node);
      } else if(tt.className == "pyret" && tt.firstChild){
        CodeMirror.runMode(tt.firstChild.nodeValue, "pyret", node);
      }
      tt.style.display = 'none';
  });
}

/*******************************************
 * EVENT HANDLERS
 *******************************************/
window.addEventListener("load", function() {
  computePageNums();
  isNewest();
  attachCodeMirror();
});
