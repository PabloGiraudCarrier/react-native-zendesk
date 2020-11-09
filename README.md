
# react-native-zendesk

React native wrapper for zendesk SDK. Supports both iOS and Android platforms.

## Getting Started

## Usage

In your code add:

Step 1. import Zendesk from 'react-native-zendesk'

### Initialisation
Place this code at the root of your application to initialize Zendesk SDK.

For all supported SDKs
```javascript
Zendesk.init({
    key: <chatAccountKey>,
    appId: <appId>,
    url: <zendeskUrl>,
    clientId: <zendeskClientId>,
})
```

Step 2. Set user identifier
- If your chat just runs behind a login you can pass in name and email whenever user logins if not, pass a JWT Token to identify the user on chat

```
    Zendesk.setUserIdentity({
        name: <name>,
        email: <email>,
    })
 ```
- If you want to start chat without any user details you can use a JWT token.
```
    Zendesk.setUserIdentity({
		token: <JWT TOKEN>
    })
```

Step 3. Show the UI based on what SDK you want to use

### Help Center
To initiate and display help center use the following method:
```
RNZendesk.showHelpCenter({
    disableTicketCreation: true,
})
```

### Customising Looks
For styling in android create a theme in your android folder with the following properties
```
<style  name="ZendeskTheme"  parent="Theme.MaterialComponents.Light">

<item  name="colorPrimary">@color/primary</item>

<item  name="colorPrimaryDark">@color/primary</item>

<item  name="colorAccent">@color/primary</item>

</style>
```
And then add following to your project's AndroidManifest.xml file (use only the SDKs you use)
```
      <activity android:name="zendesk.support.guide.HelpCenterActivity"
            android:theme="@style/ZendeskTheme" />

        <activity android:name="zendesk.support.guide.ViewArticleActivity"
            android:theme="@style/ZendeskTheme" />

        <activity android:name="zendesk.support.request.RequestActivity"
            android:theme="@style/ZendeskTheme" />

        <activity android:name="zendesk.support.requestlist.RequestListActivity"
            android:theme="@style/ZendeskTheme" />
        <activity android:name="zendesk.messaging.MessagingActivity"
            android:theme="@style/ZendeskTheme" />
```

For iOS only added a new function which can be used as below. This would set the primary color for the chat and other sdks
```
	RNZendesk.setPrimaryColor(<hex color string>)

```

## License

React Native is MIT licensed, as found in the [LICENSE](https://github.com/PabloGiraudCarrier/react-native-zendesk/LICENSE) file.
