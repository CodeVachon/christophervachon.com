component displayname="baseService" hint="I am the base of all services" {
	public baseService function init(){ return this; }


	public any function saveObject(required any objectToSave) {
		// writeDump(ARGUMENTS.objectToSave.doesValidate()); abort;
		if (ARGUMENTS.objectToSave.doesValidate()) {
			try {
				transaction {
					entitySave(ARGUMENTS.objectToSave);
					transaction action="commit";
				}
			} catch (any e) {
				//writeDump(e); abort;
				throw("Error while trying to save [#ARGUMENTS.objectToSave.getClassName()#]")
			}
		}
		return ARGUMENTS.objectToSave;
	} // close saveObject()


	public void function removeObject(required any objectToDelete) {
		ARGUMENTS.objectToDelete.setIsDeleted(true);
		this.saveObject(ARGUMENTS.objectToDelete);
	} // close removeObject()


	public any function setValuesInObject(required any objectToInsertInto, required struct values) {
		// make sure we have the latest values
		ARGUMENTS.objectToInsertInto.refreshProperties();
		for (var key in ARGUMENTS.values) {
			if ((key != "id") && (isSimpleValue(ARGUMENTS.values[key])) && (ARGUMENTS.objectToInsertInto.hasProperty(key))) {
				ARGUMENTS.objectToInsertInto.setProperty(key,trim(ARGUMENTS.values[key]));
			}
		}
		return ARGUMENTS.objectToInsertInto;
	} // close setValuesInObject()


	private struct function reduceStructLevel(required struct structToCovert) {
		var tempStruct = structNew();
		for (var key in ARGUMENTS.structToCovert) { 
			if (structKeyExists(ARGUMENTS.structToCovert,key)) {
				tempStruct[key] = ARGUMENTS.structToCovert[key]; 
			}
		}
		return tempStruct;
	}
}
