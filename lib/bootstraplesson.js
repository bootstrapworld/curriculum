// For ancient browsers that don't support .forEach()
(function(){Array.prototype.forEach||(Array.prototype.forEach=function(n,t){var u,i,r,f,e;if(this==null)throw new TypeError(" this is null or not defined");if(r=Object(this),f=r.length>>>0,typeof n!="function")throw new TypeError(n+" is not a function");for(arguments.length>1&&(u=t),i=0;i<f;)i in r&&(e=r[i],n.call(u,e,i,r)),i++})})();

/*******************************************
 * IDENTIFY OLD VERSIONS
 *******************************************/

function UrlExists(url) {
    var http = new XMLHttpRequest();
    http.open('HEAD', url, true);
    http.send();
    return (http.status !== 404)
}

function isNewest() {
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
}

/*******************************************
 * CODEMIRROR
 *******************************************/

// translate all the TEXTAREA nodes into full-blown CM instances, and color TTs with runmode
// (we use the more expensive CM stuff for indenting)
function attachCodeMirror(){
  var codeSnippets = document.querySelectorAll('tt');
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
  isNewest();
  attachCodeMirror();
});