class ProxyTest {
public static void main(String[] args) {
	
	System.out.println("JAVA Proxy");
	System.out.println("  java.version: " + System.getProperty("java.version"));
	System.out.println("  http.proxyHost: " + System.getProperty("http.proxyHost"));
	System.out.println("  http.proxyPort: " + System.getProperty("http.proxyPort"));
	System.out.println("  https.proxyHost: " + System.getProperty("https.proxyHost"));
	System.out.println("  https.proxyPort: " + System.getProperty("https.proxyPort"));
	System.out.println("  NOTE: '_JAVA_OPTIONS=-Dhttp.proxyHost=<your.proxy> -Dhttp.proxyPort=<port>'");
 
}
}
