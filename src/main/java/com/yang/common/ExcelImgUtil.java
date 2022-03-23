package com.yang.common;

import org.apache.poi.POIXMLDocumentPart;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.PictureData;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.*;
import org.openxmlformats.schemas.drawingml.x2006.spreadsheetDrawing.CTMarker;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ExcelImgUtil {
	private static int counter = 0;
	static String proFile = "D:/yc/ssmdemo/src/main/webapp/";//文件存放的路径
	/**
	 * 获取图片和位置 (xlsx)
	 * 
	 * @param sheet
	 * @return
	 * @throws IOException
	 */
	public static Map<String, PictureData> getPictures(XSSFSheet sheet) throws IOException {
		Map<String, PictureData> map = new HashMap<String, PictureData>();
		List<POIXMLDocumentPart> list = sheet.getRelations();
		for (POIXMLDocumentPart part : list) {
			if (part instanceof XSSFDrawing) {
				XSSFDrawing drawing = (XSSFDrawing) part;
				List<XSSFShape> shapes = drawing.getShapes();
				for (XSSFShape shape : shapes) {
					XSSFPicture picture = (XSSFPicture) shape;
					XSSFClientAnchor anchor = picture.getPreferredSize();
					CTMarker marker = anchor.getFrom();
					String key = marker.getRow() + "-" + marker.getCol();
					byte[] data = picture.getPictureData().getData();
					map.put(key, picture.getPictureData());
				}
			}
		}
		return map;
	}

	public static Map<String, String> printImg(Map<String, PictureData> sheetList, String path) throws IOException {
		Map<String, String> pathMap = new HashMap<String, String>();
		Object[] key = sheetList.keySet().toArray();
		File f = new File(path);
		if (!f.exists()) {
			f.mkdirs(); // 创建目录
		}
		for (int i = 0; i < sheetList.size(); i++) {
			// 获取图片流
			PictureData pic = sheetList.get(key[i]);
			// 获取图片索引
			String picName = key[i].toString();
			// 获取图片格式
			String ext = pic.suggestFileExtension();
			String fileName = encodingFilename(picName);
			byte[] data = pic.getData();

			// 图片保存路径
			String imgPath = path + fileName + "." + ext;
			FileOutputStream out = new FileOutputStream(imgPath);

			imgPath = imgPath.substring(proFile.length());// 截取图片路径
			pathMap.put(picName, imgPath);
			out.write(data);
			out.close();
		}
		return pathMap;
	}

	private static final String encodingFilename(String fileName) {
		fileName = fileName.replace("_", " ");
		fileName = Md5Utils.hash(fileName + System.nanoTime() + counter++);
		return fileName;
	}

}

