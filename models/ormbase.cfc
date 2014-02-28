/**
*
* @file  /Users/Christopher/Documents/sites/christophervachon.com/models/ormbase.cfc
* @author  
* @description
*
*/

component output="false" displayname="ormbase" extends="base" mappedSuperClass="true" {

	property name="id" fieldType="id" setter="false" type="string" ormtype="string" sqltype="varchar(50)";
	property name="createdDate" type="datetime" ormtype="timestamp" setter="false" sqltype="datetime";
	property name="lastUpdated" type="datetime" ormtype="timestamp" setter="false" sqltype="datetime";
	property name="isDeleted" type="boolean" ormtype="boolean" sqltype="bit" default="false" notnull="true";


	public function init() {
		this.refreshProperties();
		return super.init();
	}


	public void function refreshProperties() {
		if (!structKeyExists(VARIABLES,'id')) { VARIABLES.id = createUUID(); }
		if (!structKeyExists(VARIABLES,'lastUpdated')) { VARIABLES.lastUpdated = javacast("null",""); }
		if (!structKeyExists(VARIABLES,'isDeleted')) { VARIABLES.isDeleted = false; }
		if (!structKeyExists(VARIABLES,'createdDate')) { VARIABLES.createdDate = now(); }
	}


	public boolean function hasProperty(required string propertyName) hint="returns if object has the specified property" {
		ARGUMENTS.propertyName = trim(ARGUMENTS.propertyName);

		var objectProperties = getPropertyNames();

		if (arrayFindNoCase(objectProperties,ARGUMENTS.propertyName) > 0) {
			return true;
		} else {
			return false;
		}
	}


	public any function getProperty(required string propertyName) hint="returns the value of the specified property" {
		// I provide functionality to dynamically get a property value 
		if (this.hasProperty(ARGUMENTS.propertyName)) {
			if (isDefined("variables.#ARGUMENTS.propertyName#")) {
				return variables[ARGUMENTS.propertyName];
			} else {
				return javaCast("null","");
			}
		} else {
			throw("Property [#ARGUMENTS.propertyName#] does not exists");
		}
	}


	public void function setProperty(required string propertyName, required any value) {
		if (ARGUMENTS.propertyName == "id") { 
			throw("You Can Not set an ID of an Object in this Fashion");
		}
		if (this.hasProperty(ARGUMENTS.propertyName)) {
			if (!len(ARGUMENTS.value)) {
				variables[ARGUMENTS.propertyName] =  javaCast("null", 0);
			} else {
				variables[ARGUMENTS.propertyName] = ARGUMENTS.value;
			}
		} else {
			throw("Property [#ARGUMENTS.propertyName#] does not exists");
		}
	}


	public struct function getPropertyStruct() hint="returns a structure of current properties"  {
		return getTheseProperties(GetMetaData(this));
	}


	public void function preLoad() hint="call before this being populated" {}
	public void function postLoad() hint="call after this being populated" {
		this.refreshProperties();
	}
	public void function preInsert() hint="call before this being inserted" {}
	public void function postInsert() hint="call after this being inserted" {}
	public void function preUpdate(Struct oldData) hint="call before this being updated" {
		// this automatcially sets the lastUpdated timestamp before updating the object 
		VARIABLES.lastUpdated = now();
	}
	public void function postUpdate() hint="call after this being populated" {}
	public void function preDelete() hint="call before this being deleted" {}
	public void function postDelete() hint="call after this being deleted" {}


	private array function getPropertyNames(struct metaData = GetMetaData(this)) {
		var propertiesNames = [];
		if (structKeyExists(ARGUMENTS.metaData,"Properties")) {
			for (var i=1;i<=arrayLen(ARGUMENTS.metaData.properties);i++) {
				var property = ARGUMENTS.metaData.properties[i];
				arrayAppend(propertiesNames, property.name);
			}
		}
		if (structKeyExists(ARGUMENTS.metaData,"Extends")) {
			var utl = new services.utilities();
			propertiesNames = utl.mergeArrays(propertiesNames,getPropertyNames(ARGUMENTS.metaData.extends));
		}
		return propertiesNames;
	}


	private struct function getTheseProperties(struct metaData = GetMetaData(this)) {
		var properties = structNew();
		if (structKeyExists(arguments.metaData,"PROPERTIES")) {
			// loop through all defined properties 
			for (var i=1;i<=arrayLen(arguments.metaData.PROPERTIES);i++) {
				var property = arguments.metaData.PROPERTIES[i];
				if (isObject(property)) {
					properties[property.name] = property.getTheseProperties();
				} else if (isArray(property)) {
					properties[property.name] = arrayNew(1);
					for (var j=1;j<=arrayLen(property);j++) {
						var arrayValue = property[j];
						if (isObject(arrayValue)) {
							arrayAppend(properties[property.name],arrayValue.getTheseProperties());
						} else {
							arrayAppend(properties[property.name],arrayValue);
						}
					}
				} else {
					properties[property.name] = this.getProperty(property.name);
				} // close if object/array
			} // close For
			// lets get any super properties 
			if (structKeyExists(arguments.metaData,"EXTENDS") && structKeyExists(arguments.metaData.extends,"PROPERTIES")) {
				var extendedProperties = getTheseProperties(arguments.metaData.extends);
				// merge in the super properties 
				structAppend(properties,extendedProperties);
			}
		}
		return properties;
	}
}