// For ancient browsers that don't support .forEach()
(function(){Array.prototype.forEach||(Array.prototype.forEach=function(n,t){var u,i,r,f,e;if(this==null)throw new TypeError(" this is null or not defined");if(r=Object(this),f=r.length>>>0,typeof n!="function")throw new TypeError(n+" is not a function");for(arguments.length>1&&(u=t),i=0;i<f;)i in r&&(e=r[i],n.call(u,e,i,r)),i++})})();

/*******************************************
 * IDENTIFY OLD VERSIONS
 *******************************************/

function isNewest() {
  // get the current year and season
  var today = new Date();
  var month_num = today.getMonth(); // 0-6 = "Spring", 7-11 = "Fall"
  var today_year = today.getFullYear();
  var today_season;
  if(8 > month_num > 0) today_season = 'Spring'; // give ourselves until Feb to release the Spring version
  else if(month_num > 8) today_season = 'Fall'; // give ourselves until Sept to release the Fall version
  else { console.error('IMPOSSIBLE: unaccounted for month!'); return; }

  // get season from URL
  var url = window.location.href.toLowerCase();
  var url_season = (url.indexOf('fall') !== -1)? "Fall" : "Spring";
  // if it's not the current year or season, add the "obsolete" banner
  var url_current_year = url.indexOf(today_year) !== -1;
  var url_current_season = url_season == today_season;
  var outOfDate = document.createElement('div');
  outOfDate.setAttribute('id', 'outOfDate');
  outOfDate.innerHTML = 'These materials are OUT OF DATE! To get the latest version'
    + ' of the materials, visit <a href="https://www.BootstrapWorld.org/materials">'
    + 'https://www.BootstrapWorld.org/materials</a>';
  document.body.appendChild(outOfDate);
  if(!url_current_year || !url_current_season) {
    outOfDate.style.display = 'block';
    console.warn("These materials are OUT OF DATE! To get the latest version"
      + " of the materials, visit www.BootstrapWorld.org/materials");
  } else {
    outOfDate.style.display = 'none';
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
