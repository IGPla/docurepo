# Android notes

This README contains all notes and code snippets that are useful to develop android apps.

## Project preparation

- Change "android" view by "project" view in android studio tree view
- In the design view (layout), change app theme by "AppCompat.light.NoActionBar" to remove the top title on your application

## Android studio util shortcuts

- Cntrl + p: show current function's parameter names

## Dexter permissions

- Open build.gradle file and add Dexter dependency

```
implementation 'com.karumi:dexter:5.0.0'
```

- Example of Dexter permission request (Camera)

```
Dexter.withActivity(this)
                .withPermission(Manifest.permission.CAMERA)
                .withListener(new PermissionListener() {
                    @Override
                    public void onPermissionGranted(PermissionGrantedResponse response) {
                        // permission is granted, open the camera
                    }

                    @Override
                    public void onPermissionDenied(PermissionDeniedResponse response) {
                        // check for permanent denial of permission
                        if (response.isPermanentlyDenied()) {
                            // navigate user to app settings
                        }
                    }

                    @Override
                    public void onPermissionRationaleShouldBeShown(PermissionRequest permission, PermissionToken token) {
                        token.continuePermissionRequest();
                    }
                }).check();
```
