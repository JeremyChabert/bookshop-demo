using my.bookshop as db from '../db/schema';
using my.bp as bp from './external/bp';

@cds.query.limit: 100
service CatalogService {
  type DynamicAppLauncher {
    icon: String;
    info: String;
    infoState: String;
    number: Decimal(9,2);
    numberDigits: Integer;
    numberFactor: String;
    numberState: String;
    numberUnit: String;
    stateArrow: String;
    subtitle: String;
    title: String;
  }
  
  @Capabilities.SearchRestrictions.Searchable: true
  @readonly entity Books @(		
    Capabilities: {
			InsertRestrictions: {Insertable: true, Permissions:[{Scopes:[{Scope:'admin'}], SchemeName: 'Oauth'}]},
			UpdateRestrictions: {Updatable: true},
			DeleteRestrictions: {Deletable: true}
		},) as projection on db.Books excluding {
    createdBy, modifiedBy
  };
  // OData Structure for Dynamic App Launchers
  // https://help.sap.com/viewer/ad4b9f0b14b0458cad9bd27bf435637d/Cloud/en-US/8e7cec3cf6494b09a01d09606119b9dd.html
  function getNumberOfBooksForDynamicTile() returns DynamicAppLauncher;
  function hello ( to : String ) returns String;

  @readonly entity Authors as projection on db.Authors excluding {
    createdBy, modifiedBy
  };

  // @readonly entity BusinessPartner as projection on bp.BusinessPartner;

  @requires_: 'authenticated-user'
  @insertonly entity Orders as projection on db.Orders;

  @requires_: 'authenticated-user'
  @readonly
  entity UserScopes {
    key username:    String;
      is_admin:      Boolean;
      is_roleadmin:  Boolean;
      is_booksadmin: Boolean;
  };
}