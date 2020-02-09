# check tomcat version
cd tomcat/lib
java -cp catalina.jar org.apache.catalina.util.ServerInfo
# check maven dependence tree
mvn dependency:tree 
