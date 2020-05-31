function initializeCards(){
  var is_firefox = navigator.userAgent.toLowerCase().indexOf('firefox') > -1;
  if(is_firefox){
//    alert("Due to a bug in Firefox, this tutorial is best used in Chrome, Internet Explorer or Safari. We're working to fix this as soon as possible.");
  }
  window.cardIndex = 0;                                   // the index
  window.slider = document.getElementById('cards');        // the slider that gets moved
  window.progress=document.getElementById('progressbar');  // the progressbar
  window.cards = [].slice.call(slider.children);          // an array of all the cards
  document.getElementById('next').style.display = "block"; // enable the "next" button
  showRightHand();
  loadRightHand(1);
  progress.style.width = (cardIndex+1) * (100 / cards.length) + "%";
}

function nextCard(){
  // hide current content before loading the next content
  if(cards[cardIndex].content){
    cards[cardIndex].content.style.visibility = "hidden";
  }
  console.log('loading next card: '+(window.cardIndex+1));
  cardIndex++;
  if(cardIndex >= cards.length-1) document.getElementById('next').style.display = "none";
  if(cardIndex > 0) document.getElementById('prev').style.display = "block";
  showRightHand();
  slider.style.left = (cardIndex*-400) + "px";
  slider.scrollIntoView();
  setTimeout(function(){loadRightHand(cardIndex+1);}, 1000); // preload the next card's content
  progress.style.width = (cardIndex+1) * (100 / cards.length) + "%";
}

function previousCard(){
  // hide current content before loading the previous content
  if(cards[cardIndex].content){
    cards[cardIndex].content.style.visibility = "hidden";
  }
  console.log('loading previous card: '+(window.cardIndex-1));
  cardIndex--;
  if(cardIndex < cards.length) document.getElementById('next').style.display = "block";
  if(cardIndex === 0) document.getElementById('prev').style.display = "none";
  showRightHand();
  slider.style.left = (cardIndex*-400) + "px";
  loadRightHand(cardIndex-1); // preload the next card's content
  progress.style.width = (cardIndex+1) * (100 / cards.length) + "%";
  if(cards[cardIndex].content) cards[cardIndex].content.style.visibility = "visible";
}

function showRightHand(){
  loadRightHand(cardIndex); // make sure it's loaded
  if(cards[cardIndex].content) cards[cardIndex].content.style.visibility = "visible";
}

function loadRightHand(i){
  if(cards[i] && cards[i].content){
    console.log('loading from cache!');
    return;
  }
  var imageConfig = cards[i].getAttribute('imageConfig');
  if(cards[i].hasAttribute('weschemeConfig')) {
    var weschemeConfig = cards[i].getAttribute('weschemeConfig');
    var url = "https://www.WeScheme.org/openEditor?warnOnExit=false&hideHeader=true&hideToolbar=false&hideProjectName=true&hideFooter=true&name=embedded&blocksMode=true";
    if(weschemeConfig !== null){  // if it's non-null, we need to escape special chars with encodeURIComponent
      weschemeConfig = encodeURIComponent(weschemeConfig);
      url += "&definitionsText="+weschemeConfig;
    }
    console.log('loading embedded WeScheme with the following URL', url);
    cards[i].content = WeSchemeEmbedded.withoutRpc(url, "righthand");
  } else if(imageConfig){
    var img = document.createElement("img");
    img.src = imageConfig;
    document.getElementById("righthand").appendChild(img);
    cards[i].content = img;
  }
  if(cards[i].content) cards[i].content.style.visibility = "hidden";
  console.log('content loaded and cached for card '+i);
}

// forEach method, could be shipped as part of an Object Literal/Module
var forEach = function (array, callback, scope) {
  for (var i = 0; i < array.length; i++) {
    callback.call(scope, i, array[i]); // passes back stuff we need
  }
};

function attachCodeMirror(){
  // translate all the TEXTAREA nodes into full-blown CM instances, and color TTs with runmode
  // (we use the more expensive CM stuff for indenting)
  var codeSnippets = document.querySelectorAll('textarea');
  forEach(codeSnippets, function(idx, textarea){
          if(textarea.className == "racket"){
          CodeMirror.fromTextArea(textarea, {mode:"scheme2", readOnly: "nocursor"});
          } else if(textarea.className == "pyret"){
          CodeMirror.fromTextArea(textarea, {mode:"pyret", readOnly: "nocursor"});
          }
          });
  
  var codeSnippets = document.querySelectorAll('tt');
  forEach(codeSnippets, function(idx, tt){
          var node = document.createElement('span');
          node.className = 'editbox';
          tt.parentNode.insertBefore(node, tt);
          if(tt.className == "racket"){
          CodeMirror.runMode(tt.firstChild.nodeValue, "scheme2", node);
          } else if(tt.className == "pyret"){
          CodeMirror.runMode(tt.firstChild.nodeValue, "pyret", node);
          } else {
          console.log('<tt> declared without a language className');
          }
          tt.style.display = 'none';
          });
}

/************ VIDEO LIGHTBOX *********************/
window.document.onkeydown = function(e) {
  if (!e) {
    e = event;
  }
  if (e.keyCode == 27) {
    lightbox_close();
  }
}

function lightbox_open(youTubeID) {
  var lightBoxVideo = document.getElementById("embedded_video");
  lightBoxVideo.src = 'https://www.youtube.com/embed/'+youTubeID+'?autoplay=1';
  window.scrollTo(0, 0);
  document.getElementById('light').style.display = 'block';
  document.getElementById('fade').style.display = 'block';
  lightBoxVideo.play();
}

function lightbox_close() {
  var lightBoxVideo = document.getElementById("VisaChipCardVideo");
  document.getElementById('light').style.display = 'none';
  document.getElementById('fade').style.display = 'none';
  lightBoxVideo.pause();
}