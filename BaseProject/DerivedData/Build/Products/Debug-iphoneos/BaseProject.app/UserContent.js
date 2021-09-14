var jsToOCObjc = {
    evaluteOCFunction:function(funcName,params){
        window.webkit.messageHandlers.showJSToOC.postMessage(funcName,params);
    },
    returnOCData:function(funcName,params){
        window.prompt(funcName,params);
    }
};
window.jsToOCObjc = jsToOCObjc;


