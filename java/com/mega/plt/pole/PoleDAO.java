package com.mega.plt.pole;

import java.util.List;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PoleDAO {

@Autowired
SqlSessionTemplate mybatis;
	//pID를 기준으로 DB에서 전신주의 좌표를 검색해주는 함수 
	public List<PoleVO> poleList(String pID) {
		List<PoleVO> poleList = mybatis.selectList("pole.poleList", pID);
		return poleList;
		}
	//더블 값으로 받은 두 좌표(위도,경도) 값을 거리로 계산하는 함수
	public double distance(double lat1, double lon1, double lat2, double lon2, String unit) {
    
		double theta = lon1 - lon2;
		double dist = Math.sin(deg2rad(lat1)) * Math.sin(deg2rad(lat2)) 
    	+ Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * Math.cos(deg2rad(theta));
     
		dist = Math.acos(dist);
		dist = rad2deg(dist);
		dist = dist * 60 * 1.1515;
        dist = dist * 1609.344;
        return (dist);
		}
    // 각도를 십진수로 바꾸는 함수
	public double deg2rad(double deg) {
		return (deg * Math.PI / 180.0);
		}
	// 각도를 십진수로 바꾸는 함수
	public double rad2deg(double rad) {
		return (rad * 180 / Math.PI);
		}
	}