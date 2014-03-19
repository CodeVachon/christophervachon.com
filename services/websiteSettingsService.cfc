/**
*
* @file  /C/inetpub/wwwroot/finealley/FineAlleyWebsite2/services/websiteSettingsService.cfc
* @author  
* @description
*
*/

component output="false" displayname="websiteSettingsService" extends="baseService" {

	public function init(){
		return super.init();
	}


	public models.websiteSettings function getWebsiteSettings() {
		if ((structCount(ARGUMENTS) == 1) && structKeyExists(ARGUMENTS,"1")) { ARGUMENTS = reduceStructLevel(ARGUMENTS[1]); }
		var _object = javaCast("null","");

		if (structKeyExists(ARGUMENTS,"domain")) {
			_object = ORMExecuteQuery("SELECT DISTINCT w FROM websiteSettings w WHERE w.domain=:id",{id=ARGUMENTS.domain},true);
		} else if (structKeyExists(ARGUMENTS,"websiteSettingsID")) {
			_object = ORMExecuteQuery("SELECT DISTINCT w FROM websiteSettings w WHERE w.id=:id",{id=ARGUMENTS.websiteSettingsID},true);
		} else if (structKeyExists(ARGUMENTS,"id")) {
			_object = ORMExecuteQuery("SELECT DISTINCT w FROM websiteSettings w WHERE w.id=:id",{id=ARGUMENTS.id},true);
		}

		if (isNull(_object)) { _object = entityNew("websiteSettings"); }
		return _object;
	}


	public array function getAllWebsiteSettings() {
		return ORMExecuteQuery("SELECT DISTINCT w FROM websiteSettings w WHERE w.isDeleted=:isDeleted",{isDeleted=false},false);
	}


	public models.websiteSettings function editWebsiteSettings() {
		if ((structCount(ARGUMENTS) == 1) && structKeyExists(ARGUMENTS,"1")) { ARGUMENTS = reduceStructLevel(ARGUMENTS[1]); }
		return super.setValuesInObject(this.getWebsiteSettings(ARGUMENTS),ARGUMENTS);
	}


	public models.websiteSettings function editWebsiteSettingsAndSave() {
		if ((structCount(ARGUMENTS) == 1) && structKeyExists(ARGUMENTS,"1")) { ARGUMENTS = reduceStructLevel(ARGUMENTS[1]); }
		return super.saveObject(this.editWebsiteSettings(ARGUMENTS));
	}


	public models.websiteSettings function removeWebsiteSettings() {
		if ((structCount(ARGUMENTS) == 1) && structKeyExists(ARGUMENTS,"1")) { ARGUMENTS = reduceStructLevel(ARGUMENTS[1]); }
		return super.removeObject(this.getEvent(ARGUMENTS));
	}
}