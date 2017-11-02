package DispatcherService;

import ballerina.net.http;
import ballerina.lang.messages;
import ballerina.lang.system;

import PayloadBuild;


@http:configuration {basePath:"/artifactResolver",httpsPort: 9090, keyStoreFile: "${ballerina.home}/bre/security/wso2carbon.jks",
                     keyStorePass: "wso2carbon", certPass: "wso2carbon"}
service<http> dispatcherService {

    @http:POST{}
    @http:Path {value:"/dispatcher"}
    resource dispatcher (message m) {

        http:ClientConnector navigatorAether = create http:ClientConnector("http://localhost:8080/aetherService");
        http:ClientConnector navigatorNPM = create http:ClientConnector("http://localhost:9091/npmService");

        json jsonMsg = messages:getJsonPayload(m);
        message clientResponse = {};
        message request={};


        json  reqPayload; string msgPayloadType; string reqType;
        reqPayload, msgPayloadType, reqType  =  PayloadBuild:buildJsonPayload(jsonMsg);

        messages:setJsonPayload(request,reqPayload);

        if(msgPayloadType == "JavaBased"){
            if(reqType ==  "Latest Version"){

                clientResponse = navigatorAether.post("/getLatest",request);
            }else{
                clientResponse = navigatorAether.post("/getDHeirarchy",request);
            }

        }else if(msgPayloadType == "Javascript"){
            if(reqType ==  "Latest Version"){

                clientResponse = navigatorAether.post("/getLatest",request);
                }else{

            }
        }else{

        }

        reply clientResponse;
    }
}
