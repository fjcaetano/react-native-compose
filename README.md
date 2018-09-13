# react-native-compose

Compose text messages and emails from within React Native apps

## Installation

`$ npm install react-native-compose --save`

### Mostly automatic installation

`$ react-native link react-native-compose`

### Manual installation


#### iOS

1. Add to your Podfile:
   
`pod 'react-native-compose', :path => '../node_modules/react-native-compose`

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.reactlibrary.FJCComposePackage;` to the imports at the top of the file
  - Add `new FJCComposePackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-compose'
  	project(':react-native-compose').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-compose/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      implementation project(':react-native-compose')
  	```

## Usage
```javascript
import RNCompose from 'react-native-compose';

// TODO: What to do with the module?
RNCompose;
```

## License

react-native-compose is available under the MIT license. See the LICENSE file for more info.
  