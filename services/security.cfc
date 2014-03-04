/**
*
* @file  /Users/Christopher/Documents/sites/christophervachon.com/services/security.cfc
* @author  
* @description
*
*/

component output="false" displayname="security"  {

	public function init() { return this; }


	public boolean function checkPermission(required string permission) {
		if (this.checkedSignedIn()) {
			if (structKeyExists(SESSION.member,"permissions") && structKeyExists(SESSION.member.permissions,ARGUMENTS.permission))
			return SESSION.member.permissions[ARGUMENTS.permission];
		}
		return false;
	} // close checkPermission


	public boolean function checkedSignedIn() {
		return structKeyExists(SESSION,"member");
	} // close checkedSignedIn


	public boolean function signIn() {
		var personService = new services.personService();
		var _person = personService.getPerson(ARGUMENTS);

		if (_person.getPassword() == hash(ARGUMENTS.password,"md5")) {
			this.loadPersonIntoSession(_person);

			if (structKeyExists(ARGUMENTS,"rememberMe") && ARGUMENTS.rememberMe) {
				COOKIE["signIn1"] = _person.getID();
				COOKIE["signIn2"] = _person.getContactInformation()[1].getID();
			}

			return true;
		} else {
			return false;
		}
	} // close signIn


	public void function cookieSignIn() {
		if (structKeyExists(COOKIE,"signIn1") && structKeyExists(COOKIE,"signIn2")) {
			var personService = new services.personService();
			var _person = personService.getPerson(personID=COOKIE["signIn1"]);
			for (var _contactInfo in _person.getContactInformation()) {
				if (_contactInfo.getID() == COOKIE["signIn2"]) {
					this.loadPersonIntoSession(_person);
				}
			}
		}
	}


	public void function loadPersonIntoSession(required models.person user) {
		SESSION.member = {
			personId = ARGUMENTS.user.getID(),
			firstName = ARGUMENTS.user.getFirstName(),
			lastName = ARGUMENTS.user.getLastName(),
			permissions = {
				siteAdmin = ARGUMENTS.user.getSiteAdmin()
			}
		};
	} // close loadPersonIntoSession


	public void function signOut() {
		structDelete(SESSION,"member");
	}
}