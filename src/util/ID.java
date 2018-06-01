package util;

import java.util.UUID;

public class ID {
	
	public static String getId(){
		UUID uuid = UUID.randomUUID();  
        String strID = uuid.toString().replaceAll("-", ""); 
        return strID;
	}
}
