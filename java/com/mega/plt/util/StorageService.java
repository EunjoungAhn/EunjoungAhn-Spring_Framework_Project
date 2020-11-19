package com.mega.plt.util;

import java.nio.file.Files;
import java.nio.file.Paths;

import org.springframework.stereotype.Service;

import com.google.cloud.storage.BlobId;
import com.google.cloud.storage.BlobInfo;
import com.google.cloud.storage.Storage;
import com.google.cloud.storage.StorageOptions;

@Service
public class StorageService implements StorageInterface {

	@Override
	public void uploadImg(String projectID, String bucketName, String objectName, String filePath) throws Exception {
		Storage storage = StorageOptions.newBuilder().setProjectId(projectID).build().getService();
		BlobId blobId = BlobId.of(bucketName, objectName);
		BlobInfo blobInfo = BlobInfo.newBuilder(blobId).build();
		storage.create(blobInfo, Files.readAllBytes(Paths.get(filePath)));

		System.out.println("1. google cloud storage에 저장 완료 [" + filePath +"]");
	}
}
