import { useState, useRef, useEffect } from 'react';
import { makeEmbed } from 'pyret-embed';
import { selfGuidedBits, selfGuidedTitle } from './selfGuidedBits';
import { RotatingLines } from "react-loader-spinner";

const numSelfGuidedPages = selfGuidedBits.length;

function createLeftPane(lessonText) {
  // console.log('doing createLeftPane of', lessonText);
  return <div dangerouslySetInnerHTML={{__html: lessonText}} />
}

const EditorPane = ({config}) => {
  console.log('creating editorPane', config);

  // state for showing loading indicator
  const [isLoading, setIsLoading] = useState(true);

  // create a ref, so that we can render into the DOM
  const containerRef = useRef(null);

  window.containerRef = containerRef;
  
  // if the ref has been rendered (i.e. - has a current node),
  // render parley into it
  useEffect( () => {

    async function makeEditor(title, node) {
      // prepend the context (although I don't think we actually want to do this!)

      // console.log('doing makeEditor');

      // If this node already has an editor, use that. Otherwise make a new one
      const embed = (!containerRef.current ? null :
        (containerRef.current.editor ||
          await makeEmbed("Embedded Editor", containerRef.current, "https://pyret-horizon.herokuapp.com/editor")));

      // hide the loading indicator
      setIsLoading(false);

      // Save the editor to the node
      if (containerRef.current) {
        containerRef.current.editor = embed;
      }

      // set the editor
      if (embed) {
        const config0 = {
          definitionsAtLastRun: "",
          interactionsSinceLastRun: "",
          editorContent: "",
          replContents: "",
        };

        embed.sendReset({...config0, ...config});
      }
    }

    makeEditor();
  }, [containerRef, config]);

  // the "loading" spinner, which is null if we're done loading
  const spinner = isLoading? (
      <div style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100vh' }}>
        <RotatingLines
          strokeColor="grey"
          strokeWidth="5"
          animationDuration="0.75"
          width="96"
          visible={true}
        />
      </div>
    ) : null;

  return (
    <div>
      {spinner}
      <div id="selfGuidedId" ref={containerRef} style={{display:isLoading? "none" : "unset"}}></div>
    </div>);
}

const ImagePane = ({config}) => {
  console.log('creating imagePane', config)
  return ( <img src={config} /> );
}

const VideoPane = ({config}) => {
  console.log('creating VideoPane', config);
  return (
    <video controls autoplay>
      <source src={config} type="video/mp4" />
    </video>);
}

export async function addToEditor(x) {
  // console.log('doing addToEditor', x);
  const containerRef = window.containerRef; // checks?
  // console.log('containerRef=', containerRef);
  const embed = containerRef.current.editor; // 〃
  // console.log('embed=', embed);
  embed.runDefinitions();
  embed.setInteractions(x.trim() + '\n');
  await embed.runInteractionResult();
}

window.addToEditor = addToEditor

export function SelfGuided() {
  // console.log('making SelfGuided');
  const [index, setIndex] = useState(0);
  let twinPane = selfGuidedBits[index];

  function handleClickNext() {
    // console.log('doing clicknext');
    setIndex((index === (numSelfGuidedPages - 1)) ? 0 : (index + 1));
  }

  function handleClickPrev() {
    // console.log('doing clickprev');
    setIndex((index === 0) ? (numSelfGuidedPages - 1) : (index - 1));
  }

  let leftPane = createLeftPane(twinPane.lessonText);
  let rightPane;

  if(twinPane.editorCode) {
    rightPane = <EditorPane config={twinPane.editorCode}/>
  } else if(twinPane.videoConfig) {
    rightPane = <VideoPane config={twinPane.videoConfig} />
  } else if(twinPane.imageConfig) {
    rightPane = <ImagePane config={twinPane.imageConfig} />
  } else {
    throw "Invalid configuration provided: "+JSON.stringify(twinPane, null, 2);
  }


  // console.log('hc index is', index);
  // console.log('lessonText is', twinPane.lessonText);
  // console.log('editorCode is', twinPane.editorCode);

  return (
    <>
    <div id="banner">
      <img src="./icon.png" height="50" />
      <span>Bootstrap :: {selfGuidedTitle}</span>
    </div>
    <div id="progressbar" style={{width: (index + 1) * (100 / numSelfGuidedPages) + "%"}}></div>
    <h1>{selfGuidedTitle}</h1>
    <main>
      <div id="buttons">
        <button id="prev"
                onClick={handleClickPrev}
                disabled={index>0? '' : 'yes'}>
          «
        </button>
        <button id="next"
                onClick={handleClickNext}
                disabled={index < selfGuidedBits.length - 1? '' : 'yes'}>
          »
        </button>
      </div>
      <h2>({index+1} of {numSelfGuidedPages})</h2>
      <div id="pages">
        <div id="leftPane">
          {leftPane}
        </div>
        <div id="rightPane">
          {rightPane}
        </div>
      </div>
    </main>
    <div id="footer">
      <a href="https://www.BootstrapWorld.org">Bootstrap</a> is brought to you by the <a href="https://www.BootstrapWorld.org/community">Bootstrap Team</a>. Special thanks to <a href="http://www.ProgramByDesign.org">Program by Design</a> and <a href="https://www.Brown.edu">Brown University</a>.
    </div>
    </>
  );

}
