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
				var cookieMonster = new services.cookieMonster();
				cookieMonster.setCookie("signIn1",_person.getID());
				cookieMonster.setCookie("signIn2",_person.getContactInformation()[1].getID());
			}

			return true;
		} else {
			return false;
		}
	} // close signIn


	public void function cookieSignIn() {
		var cookieMonster = new services.cookieMonster();

		if (cookieMonster.doesExists("signIn1") && cookieMonster.doesExists("signIn2")) {
			var personService = new services.personService();
			var _person = personService.getPerson(personID=cookieMonster.getValue("signIn1"));
			for (var _contactInfo in _person.getContactInformation()) {
				if (_contactInfo.getID() == cookieMonster.getValue("signIn2")) {
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
		var cookieMonster = new services.cookieMonster();
		cookieMonster.deleteCookie("signIn1");
		cookieMonster.deleteCookie("signIn2");
		structDelete(SESSION,"member");
	}
}