let cardIndex, slider, progress, cards, editor, parley, righthand;

window.onload = () => {
  cardIndex = 0;                                        // the index
  slider    = document.getElementById('cards');         // the slider that gets moved
  progress  = document.getElementById('progressbar');   // the progressbar
  cards     = [].slice.call(slider.children);           // an array of all the cards
  editor    = document.createElement("div");
  parley    = window.embedableParley.renderParley(editor);
  righthand = document.getElementById("righthand");
  loadFromConfig(cardIndex);
  updateSliderAndButtons();
  progress.style.width = (cardIndex+1) * (100 / cards.length) + "%";
}

function updateSliderAndButtons() {
  document.getElementById('prev').style.display = (cardIndex === 0)? "none" : "block"
  document.getElementById('next').style.display = (cardIndex >= cards.length-1)? "none" : "block";
  slider.style.left = (cardIndex*-400) + "px";
  slider.scrollIntoView();
  progress.style.width = (cardIndex+1) * (100 / cards.length) + "%";
  loadFromConfig(cardIndex);
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

  const editorConfig= cards[i].getAttribute('editorCode'),
        imageConfig = cards[i].getAttribute('imageConfig');

  if(editorConfig) {
    righthand.appendChild(editor);
    parley.resetChunks(editorConfig.trim().split("\n") || [""]);
  } else if(imageConfig) {
    var img = document.createElement("img");
    img.src = imageConfig;
    righthand.appendChild(img);
  }
}

function addToEditor(lines) {
  const newChunks = lines.split("\n");
  newChunks.forEach((c) => parley.addChunk(c));
  parley.run();
}
