# honesty
I have made a clone app for Sarahah. 

You guys have to create your own Info.plist file and with this Info.plist file you have to create a new Firebase Project
and include GoogleService-Info.plist to your project.

Email/password authentication must be enabled. And database rules might be like this:

```javascript
{
  "rules": {
    ".read": "auth != null",
    ".write": "auth != null",
	  "users": {
      ".indexOn": "username"
    }
  }
}
```

Whole project actually based on 5 ViewControllers. Including UITableViewController & UICollectionViewController.

![alt text](https://i.hizliresim.com/PO5qQ6.png)
![alt text](https://i.hizliresim.com/g9k5XZ.png)
![alt text](https://i.hizliresim.com/9DV4Go.png)
