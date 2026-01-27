# Rive splash animation

Put your splash Rive file here:

**Path:** `pinterest/Resources/pinterest-splash.riv`

- **File name:** `pinterest-splash.riv` (matches the default in `LaunchScreenView`)
- **Or** use another name and pass it when creating the view: `LaunchScreenView(riveFileName: "your_file_name")`

## Add the file in Xcode

1. In Finder, copy your `.riv` file into this folder:  
   `pinterest/Resources/`
2. In Xcode, the file should appear under **pinterest → Resources** (project uses folder sync).
3. If it doesn’t show, **File → Add Files to "pinterest"…** and choose your `.riv` file.
4. **Important:** In the file inspector, ensure your **pinterest** app target is checked under **Target Membership**.
5. In Xcode: **Target “pinterest” → Build Phases → Copy Bundle Resources**. Confirm `pinterest-splash.riv` is listed. If not, click **+** and add it.

## “fopen failed for data file: errno = 2”

That usually means either:

1. **The .riv file isn’t in the app bundle**
   - Add `pinterest-splash.riv` to **Copy Bundle Resources** (see above).
   - Clean build (**Product → Clean Build Folder**) and run again.

2. **The .riv file uses referenced assets**
   - If the Rive file was exported with “referenced” fonts/images, the runtime tries to load them and fails if they’re not in the app.
   - **Fix:** In the Rive editor, re-export the file with those assets set to **Embedded**, or add the referenced asset files to the app bundle and use a `customLoader` when creating `RiveViewModel`.
