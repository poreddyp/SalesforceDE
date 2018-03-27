global class ModernSalesforce {
    global class Contact {
      public String name;
      public Integer id;
      public Contact(String name, Integer id) {
        this.name = name;
        this.id = id;
      }
    }
    @RemoteAction
    webservice static String getContacts() {
      List<Contact> contacts = new List<Contact>();
      contacts.add(new Contact('Madeleine Black', 11));
      contacts.add(new Contact('Frank Pullman', 12));
      contacts.add(new Contact('Samantha Hill', 13));
      contacts.add(new Contact('Sam Ince', 14));
      contacts.add(new Contact('Joseph Hughes', 15));
      contacts.add(new Contact('Karen Randall', 16));
      contacts.add(new Contact('Benjamin Manning', 17));
      contacts.add(new Contact('Katherine Wright', 18));
      contacts.add(new Contact('Thomas Vance', 19));
      return JSON.serialize(contacts);
    }
}