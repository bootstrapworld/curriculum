var WeSchemeEmbedded = (function() {
    var WithRpc = function(url, containerName) {
        var container = document.getElementById(containerName);
        this.rpc =
             new easyXDM.Rpc({ remote: url,
                               container: containerName,
                               props: {style: {width: "100%", height: "100%"}},
                             },
                             {remote : { run : {},
                                         requestBreak : {},
                                         setDefinitionsText : {},
                                         getDefinitionsText : {}}});
    };

    WithRpc.prototype.run = function(onSuccess, onFail) {
        this.rpc.run(onSuccess, onFail);
    };

    WithRpc.prototype.requestBreak = function(onSuccess, onFail) {
        this.rpc.requestBreak(onSuccess, onFail);
    };

    WithRpc.prototype.setDefinitionsText = function(v, onSuccess, onFail) {
        this.rpc.setDefinitionsText(v, onSuccess, onFail);
    };



    var WithoutRpc = function(url, containerName) {
        var container = document.getElementById(containerName);
        var iframe = document.createElement("iframe");
        var refresh = document.createElement("span");
        var parent = document.createElement("div");
        refresh.innerHTML = "&#x27F3 Refresh";
        refresh.className = "refreshButton";
        refresh.title = "Refresh WeScheme Editor";
        refresh.onclick = function(){
          parent.removeChild(iframe);
          parent.removeChild(refresh);
          WithoutRpc(url, containerName);
        }
        iframe.style.width="100%";
        iframe.style.height="100%";
        parent.className = "embeddedWescheme";
        parent.appendChild(iframe);
        parent.appendChild(refresh);
        container.appendChild(parent);
        iframe.src = url;
        this.parent = parent;
    };

    var WeSchemeEmbedded = {};
    WeSchemeEmbedded.withRpc = function(url, containerName) {
        return new WithRpc(url, containerName);
    };

    WeSchemeEmbedded.withoutRpc = function(url, containerName) {
        return new WithoutRpc(url, containerName).parent;
    };

    return WeSchemeEmbedded;
}());
