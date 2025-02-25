let cardIndex, slider, progress, cards, editor, parley, righthand;

window.onload = () => {
  cardIndex = 0;                                        // the index
  slider    = document.getElementById('cards');         // the slider that gets moved
  progress  = document.getElementById('progressbar');   // the progressbar
  cards     = [].slice.call(slider.children);           // an array of all the cards
  editor    = document.createElement("div");
  parley    = window.embedableParley.renderParley(editor);
  parley._dispatch({type: 'update', key: 'updater', value: (s) => ({ ...s, enterNewline: false })});
  parley.onReady(() => clearLoadingScreenAndRun());
  righthand = document.getElementById("righthand");
  updateSliderAndButtons();
  progress.style.width = (cardIndex + 1) * (100 / cards.length) + "%";
}

function updateSliderAndButtons() {
  document.getElementById('prev').style.display = (cardIndex === 0)? "none" : "block"
  document.getElementById('next').style.display = (cardIndex >= cards.length-1)? "none" : "block";
  slider.style.left = (cardIndex * -400) + "px";
  slider.scrollIntoView();
  progress.style.width = (cardIndex + 1) * (100 / cards.length) + "%";
  loadFromConfig(cardIndex);
}

function clearLoadingScreenAndRun() {
  document.getElementById('righthand').style.opacity = 1;
  document.getElementById('loadingScreen').classList.add('loaded');
  parley.run();
}

function nextCard() {
  cardIndex++;
  updateSliderAndButtons();
}

function previousCard() {
  cardIndex--;
  updateSliderAndButtons();
}

function loadFromConfig(i = cardIndex) {
  if(i > cards.length-1) return; // if there's no more cards, bail

  // clear any content
  while(righthand.firstChild) { righthand.removeChild(righthand.firstChild); }

  document.getElementById('reset').style.display = 'none';

  const editorConfig= cards[i].getAttribute('editorCode'),
        imageConfig = cards[i].getAttribute('imageConfig')
        videoConfig = cards[i].getAttribute('videoConfig')
        pyretConfig = cards[i].getAttribute('pyretConfig');

  if(editorConfig) {
    clearTimeout(window.parleyTimeout);
    righthand.appendChild(editor);
    parley.resetChunks(editorConfig.trim().split("\n") || [""]);
    document.getElementById('reset').onclick = () => {
      righthand.classList.add('resetting');
      loadFromConfig();
      setTimeout( () => righthand.classList.remove('resetting'),
        2000)
    }
    document.getElementById('reset').style.display = 'block';
    window.parleyTimeout = setTimeout(() => parley.run(), 500);
  } else if(imageConfig) {
    var img = document.createElement("img");
    img.src = imageConfig;
    righthand.appendChild(img);
  } else if (videoConfig) {
    var video = document.createElement("video");
    righthand.appendChild(video);
    video.src = videoConfig;
    video.controls = true;
    video.style.display = 'none';
    // after the video is loaded, give the browser 500ms and then set dimensions
    video.onloadstart = function(v) { 
      setTimeout(function() {
        video.style.height = v.srcElement.videoHeight;
        video.style.maxWidth = v.srcElement.videoWidth;
        video.style.display = "block";
        video.play();
      }, 500);
    }
  } else if (pyretConfig) {
    var frame = document.createElement("div");
    frame.id = pyretConfig;
    righthand.appendChild(frame);
    window[pyretConfig](frame);
  }
}

function addToEditor(lines) {
  const newChunks = lines.trim().split("\n");
  newChunks.forEach((c) => parley.addChunk(c));
  parley.run();
}
