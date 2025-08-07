package helper;

import java.util.Random;

import secret.VERIFY_CODE;

public class GeneratePinCode {
	public static String getCode() {
		String possibleCodeCharacter = VERIFY_CODE.getAllCode();
		Random rand = new Random();
		StringBuilder strBuilder = new StringBuilder();
		int index = 0;
		while (strBuilder.length() < 6) {
			index = (int) (rand.nextFloat() * 75);
			strBuilder.append(possibleCodeCharacter.charAt(index));
		}
		String verifyCode = strBuilder.toString();
		return verifyCode;
	}
}
