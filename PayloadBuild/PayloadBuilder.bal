package PayloadBuild;

import ballerina.lang.jsons;
import ballerina.lang.strings;



function buildJsonPayload (json incomingPayload) (json replyPayload, string payloadType, string reqType) {

    payloadType = jsons:toString(incomingPayload.Type);


    if (payloadType == "JavaBased") {
        string artifactID  =  jsons:toString(incomingPayload.ArtifactID);
        string groupID = jsons:toString(incomingPayload.GroupID);
        if(incomingPayload.Version != null){
                string version = jsons:toString(incomingPayload.Version);
                if(strings:contains(groupID,"wso2")){
                    replyPayload= {"repoID":"central",
                                      "repoType":"default",
                                      "repoUrl":"http://dist.wso2.org/maven2/",
                                      "groupID":groupID,
                                      "artifactID":artifactID,
                                      "version":version
                                  };
                }else{
                    replyPayload= {"repoID":"central",
                                      "repoType":"default",
                                      "repoUrl":"http://central.maven.org/maven2/",
                                      "groupID":groupID,
                                      "artifactID":artifactID,
                                      "version":version
                                  };
                }
                reqType = "Dependency Heirarchy";
        } else {
           if(strings:contains(groupID,"wso2")){
               replyPayload= {"repoID":"central",
                                 "repoType":"default",
                                 "repoUrl":"http://dist.wso2.org/maven2/",
                                 "groupID":groupID,
                                 "artifactID":artifactID
                             };
           }else{

               replyPayload= {"repoID":"central",
                                 "repoType":"default",
                                 "repoUrl":"http://central.maven.org/maven2/",
                                 "groupID":groupID,
                                 "artifactID":artifactID
                             };
           }
           reqType = "Latest Version";
       }

    } else if (payloadType == "Javascript") {
        string pkgName  =  jsons:toString(incomingPayload.PackageName);
        if(incomingPayload.Version != null){

        }else{
            replyPayload= {"pkgName":pkgName};
            reqType = "Latest Version";
        }
    } else {
        replyPayload = {"Error":"Error in building payload"};
    }

    return replyPayload, payloadType, reqType;

}



