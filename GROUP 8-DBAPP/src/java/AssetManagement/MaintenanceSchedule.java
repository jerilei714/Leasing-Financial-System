/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package AssetManagement;

import java.util.Date;

/**
 *
 * @author ccslearner
 */
public class MaintenanceSchedule {
    public int maintenance_schedule_id;
    public String frequency;
    public int asset_id;
    public String asset_name;
    public String asset_type;
    public Date last_maintenance_;
    public Date next_maintenance;

    public int getMaintenance_schedule_id() {
        return maintenance_schedule_id;
    }

    public String getFrequency() {
        return frequency;
    }

    public int getAsset_id() {
        return asset_id;
    }

    public Date getLast_maintenance_() {
        return last_maintenance_;
    }

    public Date getNext_maintenance() {
        return next_maintenance;
    }

    public String getAsset_name() {
        return asset_name;
    }
    
    public String getAsset_type() {
        return asset_type;
    }

    //setters
    public void setMaintenance_schedule_id(int maintenance_schedule_id) {
        this.maintenance_schedule_id = maintenance_schedule_id;
    }

    public void setFrequency(String frequency) {
        this.frequency = frequency;
    }

    public void setAsset_id(int asset_id) {
        this.asset_id = asset_id;
    }
    
   public void setAsset_type(String asset_type) {
        this.asset_type = asset_type;
    }

    public void setLast_maintenance_(Date last_maintenance_) {
        this.last_maintenance_ = last_maintenance_;
    }

    public void setNext_maintenance(Date next_maintenance) {
        this.next_maintenance = next_maintenance;
    }

    public void setAsset_name(String asset_name) {
        this.asset_name = asset_name;
    }

    public MaintenanceSchedule(){
        
    }
}

