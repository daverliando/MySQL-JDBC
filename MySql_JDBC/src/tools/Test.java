/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tools;

import daos.RegionDAO;
import models.Region;

/**
 *
 * @author DevidBa
 */
public class Test {

    public static void main(String[] args) {
        DbConnection connection = new DbConnection();
        System.out.println(connection.getConncetion());
        
        RegionDAO rdao = new RegionDAO(connection.getConncetion());
        for (Region region : rdao.getAll()) {
            System.out.println(region.getRegionId());
            System.out.println(region.getRegionName());
        }
        
//        Region region = new Region(0, "Nan Jauh Dimato");
//        System.out.println(rdao.insert(region));
    }
}
