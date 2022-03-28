package _00_init;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.EnumMap;
import java.util.Map;


import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Image;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfWriter;

public class ZxingQRCode {

	public static void main(String[] args) throws FileNotFoundException, DocumentException {	
		Document document = new Document(new Rectangle(340, 842));

		PdfWriter writer = PdfWriter.getInstance(document,
				new FileOutputStream("C:\\Users\\Yvexchiang\\ttest\\test25.pdf"));

		document.open();

		BufferedImage bufferedImage = ZxingQRCode.barCode39("LL1001301020190119", 300, 50, 0);
		try {
			Image img = Image.getInstance(bufferedImage, null);
			
			img.setAbsolutePosition(20, 20);
			img.scalePercent(50);
			
			document.add(img);
			document.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 生成條碼 條碼的寬度不能等於圖片的寬度，否則解析不出來,如果解析不出來，請加大offset的值
	 *
	 * @param contents 內容
	 * @param width    寬度
	 * @param height   高度
	 * @param offset   偏移量
	 * @throws WriterException
	 * @throws FileNotFoundException
	 * @throws IOException
	 */
	public static BufferedImage barCode39(String contents, int width, int height, int offset) {
		BufferedImage image = null;
		try {
			BitMatrix matrix = new MultiFormatWriter().encode(contents, BarcodeFormat.CODE_39, width - offset, height);

			image = MatrixToImageWriter.toBufferedImage(matrix);

		} catch (WriterException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return image;
	}

	public static BufferedImage qrCode(String myCodeText) {
//		String filePath = "testPDF/CrunchifyQR.png";
//		String fileType = "png";
//		File myFile = new File(filePath);

		int size = 250;
		BufferedImage image = null;
		try {
//			if(!myFile.isDirectory()) myFile.getParentFile().mkdirs();

			Map<EncodeHintType, Object> hintMap = new EnumMap<EncodeHintType, Object>(EncodeHintType.class);
			hintMap.put(EncodeHintType.CHARACTER_SET, "UTF-8");
			hintMap.put(EncodeHintType.MARGIN, 1); /* default = 4 */
			hintMap.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.L);
			hintMap.put(EncodeHintType.QR_VERSION, 6);

			QRCodeWriter qrCodeWriter = new QRCodeWriter();
			BitMatrix byteMatrix = qrCodeWriter.encode(myCodeText, BarcodeFormat.QR_CODE, size, size, hintMap);
			int CrunchifyWidth = byteMatrix.getWidth();
			image = new BufferedImage(CrunchifyWidth, CrunchifyWidth, BufferedImage.TYPE_INT_RGB);
			image.createGraphics();

			Graphics2D graphics = (Graphics2D) image.getGraphics();
			graphics.setColor(Color.WHITE);
			graphics.fillRect(0, 0, CrunchifyWidth, CrunchifyWidth);
			graphics.setColor(Color.BLACK);

			for (int i = 0; i < CrunchifyWidth; i++) {
				for (int j = 0; j < CrunchifyWidth; j++) {
					if (byteMatrix.get(i, j)) {
						graphics.fillRect(i, j, 1, 1);
					}
				}
			}
//			ImageIO.write(image, fileType, myFile);
		} catch (WriterException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return image;
	}
}
