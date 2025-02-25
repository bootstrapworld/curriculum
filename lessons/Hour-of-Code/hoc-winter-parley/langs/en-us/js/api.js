const CPO = "https://pyret-horizon.herokuapp.com/editor#controlled=true";
//const CPO = "http://localhost:4999/editor#controlled=true";
//const CPO = "https://pyret-vmt-dfb765867402.herokuapp.com/editor#controlled=true";

function makeEmbed(id, container) {
  let messageNumber = 0;
  let currentState = null;
  function sendReset(frame, state) {
    if(!state) {
      state = {
        definitionsAtLastRun: false,
        interactionsSinceLastRun: [],
        editorContents: "use context starter2024",
        replContents: ""
      };
    }
    state.messageNumber = 0;
    currentState = state;
    const payload = {
      data: {
        type: 'reset',
        state: typeof state === "string" ? state : JSON.stringify(state)
      },
      protocol: 'pyret'
    };
    console.log("Sending", payload);
    frame.contentWindow.postMessage(payload, '*');
  }

  function gainControl(frame) {
    frame.contentWindow.postMessage({
      type: 'gainControl'
    }, '*');
  }

  function setInteractions(frame, text) {
    messageNumber += 1;
    const change = {
      from: { line: 0, ch: 0 },
      to: { line: 0, ch: 0 },
      text: text
    };
    currentState = { messageNumber, ...currentState, replContents: text };
    const payload = {
      protocol: 'pyret',
      data: {
        type: 'changeRepl',
        change: change
      },
      state: currentState
    };
    frame.contentWindow.postMessage(payload, '*');
  }

  let resultCounter = 0;

  function runInteractionResult(frame) {
    const { promise, resolve, reject } = Promise.withResolvers();
    messageNumber += 1;
    const newInteractions = currentState.interactionsSinceLastRun.concat([currentState.replContents])
    currentState = {
        ...currentState,
        messageNumber: messageNumber,
        interactionsSinceLastRun: newInteractions,
        replContents: "",
    };
    const payload = {
      protocol: 'pyret',
      data: {
        type: 'runInteraction',
        reportAnswer: 'interaction' + (++resultCounter)
      },
      state: currentState
    };
    frame.contentWindow.postMessage(payload, '*');
    window.addEventListener('message', message => {
      if(message.data.protocol !== 'pyret') { return; }
      if(message.source !== frame.contentWindow) { return; }
      const pyretMessage = message.data;
      if(pyretMessage.data.type === 'interactionResult') {
        resolve(pyretMessage.data.textResult);
      }
    });
    return promise;
  }

  function directPostMessage(frame, message) {
    frame.contentWindow.postMessage(message);
  }

  const frame = document.createElement("iframe");
  frame.id = id;
  frame.src = CPO;
  frame.width = "100%";
  container.appendChild(frame);

  const { promise, resolve, reject } = Promise.withResolvers();
  setTimeout(() => reject(new Error("Timeout waiting for Pyret to load")), 60000);

  window.addEventListener('message', message => {
    if(message.data.protocol !== 'pyret') {
      return;
    }
    if(message.source !== frame.contentWindow) {
      return;
    }
    const pyretMessage = message.data;
    if(pyretMessage.data.type === 'pyret-init') {
      console.log("Sending gainControl", pyretMessage);
      gainControl(frame);
      resolve(makeEmbedAPI(frame));
    }
    else {
      currentState = pyretMessage.state;
    }
  });
  function makeEmbedAPI(frame) {
    return {
      sendReset: (state) => sendReset(frame, state),
      postMessage: (message) => directPostMessage(frame, message),
      getFrame: () => frame,
      setInteractions: (text) => setInteractions(frame, text),
      runInteractionResult: async () => await runInteractionResult(frame)
    }
  }
  return promise;
}