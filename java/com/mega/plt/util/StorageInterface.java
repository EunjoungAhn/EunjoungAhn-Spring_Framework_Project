package com.mega.plt.util;

public interface StorageInterface {
	void uploadImg(String projectID, String bucketName, String objectName, String filePath) throws Exception;
}