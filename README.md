# WibbleWobble v1.4


[![Watch the video](https://img.youtube.com/vi/UCsU6N2qzyI/0.jpg)](https://youtu.be/UCsU6N2qzyI)

## Why WibbleWobble

1. **Many games don't support multi-view rendering and those that do support it require the world rendered for each view to fill all monitors.:**
   - WibbleWobble allows the game to render a single view and reprojects that view across the user's desktop using a high performance shader. 
     This means that the world is rendered through a single view and that view is placed in front of the user via head tracking, saving performance.
   - Because WibbleWobble controls the size of the game window, performance is scalable.
   - Because the user is able to select their desired FOV, performance is scalable.

2. **VR accessibility issues.:**
   - Some people want to use VR but they may have physical disabilties that prevent them from enjoying VR.
   - WibbleWobble allows the user to have a VR-alike immersive experience without the need to wear a headset in both monoscopic and stereoscopic modes.
 
3. **NVIDIA killed sequential stereoscopic on 3x series and up cards.:**
   - WibbleWobble implements sequential stereoscopic in open source with the help of Reshade effects such as SuperDepth3D.
   - WibbleWobble also has arduino sketches for controlling XPand IR shutter glasses as well as any VESA stereoscopic sender unit.
   - You don't need a special stereoscopic monitor or video card for this to work either; a 120hz+ monitor with a low response time and preferrably some form of motion blur reduction should work however YMMV.

4. **People have a hard time figuring out the right FOV for games to suit their sim rigs; giant world, distortions etc..:**
   - WibbleWobble requires the user to setup their display rig one time only and then input a matching FOV value per game to get a life size reprojection every time.
   - WibbleWobble also does not require head tracking and can be simply used to reproject the view to real world size.

---

# Limitations

1. **Currently does not work with TrackIR hardware:**
   - If anyone knows a workaround for using TrackIR hardware with OpenTrack please let me know by raising an issue on GitHub.

2. **Head Tracking only works with TrackIR supported games:**
   - WibbleWobble provides similar game support as the freetrack 2.0 enhanced output in OpenTrack.
   - Unless you want to support the WibbleWobble public api for head tracking in your application.

3. **Currently does not support freetrack:**
   - This should be a fairly simple fix but I haven't even thought about it, any ideas please raise an issue on GitHub.

---

# WibbleWobble Setup and Configuration

## Initial Setup

1. **Download and unzip the latest release:**
	[Releases Here](https://github.com/PHARTGAMES/WibbleWobbleCore/releases)

2. **Register WibbleWobble:**  
   In Windows Explorer, right-click `WibbleWobbleClient/Register.bat` and select **Run as administrator**.

3. **Disable Desktop Scaling:**  
   Disable desktop scaling in Windows settings. WibbleWobble and some games are not DPI aware, and scaling can cause window size issues. (For example, Assetto Corsa.)

---

## OpenTrack Setup

1. **Install OpenTrack (Win32):**  
   Version 1.0 of WibbleWobble only supports the Win32 version of OpenTrack. Choose the appropriate installer based on your head tracking device:
   - [Neural net face tracker and others (OpenTrack 2023.3.0)](https://github.com/opentrack/opentrack/releases/tag/opentrack-2023.3.0)
   - [TrackHat V2 (OpenTrack 3.2 Win32)](https://www.dropbox.com/s/m0x8536mjj32gts/trackhat-opentrack-3.2-win32-setup.exe?dl=1)
   - [TrackHat V1 (OpenTrack 2.2b Win32)](https://www.dropbox.com/s/tdz5uayhqfkt00c/trackhat-opentrack-2.2b-win32-setup.exe?dl=1)

2. **Copy Modules Folder:**  
   Copy the `modules` folder from `WibbleWobbleClient/OpenTrack/Win32` into your OpenTrack installation directory.

3. **Configure OpenTrack:**  
   - WibbleWobble.ini is provided in the modules/presets folder and should contain these settings already but in case something gets changed accidentally, here are each of the settings.
   - Run OpenTrack and select **wibblewobbletrack** as the output.
   - Click the **Hammer (Settings)** button next to wibblewobbletrack to open the configuration UI.
   - Under **Selected Interface**, choose **"Use TrackIR, disable freetrack"**.
   - Check **Custom location** and browse to `WibbleWobbleClient/NPClient`.
   - Under **Mapping Properties**, set:
     - **X, Y, Z**: Max Input = 100cm, Max Output = 100cm.
   - **Yaw Max Input** = 180  
   - **Pitch Max Input** = 90, Max Output = 90  
   - **Roll Max Input** = 180
   - Map the **Center** shortcut to **"Shift+."** so WibbleWobble and OpenTrack recenter together.
   - Under **Output for Axis Assignment**, assign **Yaw, Pitch, Roll, X, Y, Z** 1:1 with no remapping.
   - Disable **Relative translation**.

---

## Installation for Each Game

1. **Install Reshade Addon:**  
   Run `WWReshadeAddon/Reshade/ReShade_Setup_6.3.3_Addon.exe` . WibbleWobble v1.0 only supports DX11 and DX12.  
   *Note: Do not use this version of Reshade with games that have anti-cheat. Use at your own risk.*
   - Install Reshade into the game you want to use. (Depending on the game you may need to perform extra steps to make Reshade work).

2. **Copy WWReshadeAddon Files:**  
   Copy the contents of `WWReshadeAddon/Release/architecture` into the same folder as the game’s executable (where you installed Reshade).
   - For 64-bit games, use the contents of `x64`.
   - For 32-bit games, use the contents of `Win32`.

3. **Run the Game:**  
   After starting the game, complete or skip the Reshade tutorial and close the Reshade UI.

4. **Use Windowed Mode:**  
   Put the game into Windowed mode. WibbleWobble will not function in fullscreen mode.

---

## Launch Workflow

1. **Start the Game:**  
   Launch the game and reach a point where you're viewing the in-game world.

2. **Launch WibbleWobble:**  
   Press **Shift + End** to start WibbleWobble.

3. **Configure or Play:**  
   Once launched, you can adjust WibbleWobble’s settings or begin playing.

4. **Maintain Focus on the Game Window:**  
   The game window should remain in focus. If the WibbleWobble window is in focus when the WibbleWobble UI is closed, alt+tab or click on the game window to focus it. This should happen automatically, but if not, refocus manually.
   
5. **ReCenter the view:**
   Place your head at the centre of the play space and press **"Shift+."** to recenter tracking. You need to do this every time you run WibbleWobble to center the tracking.
   If the reprojection behaves strangely such as scaling irregularly this means your head is in the wrong position when recentering. You may need to move your head a little closer or further away than expected when recentering; this takes some practice.

6. **OPTIONALLY: Toggle the overlay focus:**
   Press **"Shift+/"** to toggle the focus on the overlay. You can do this to be able to use the mouse accurately within the game. There is a mouse cursor fix coming to remove the need to do this.

7. **Don't close the WibbleWobble window**
   WibbleWobble will currently not recover if you close the WibbleWobble window. You must restart the game if you do this. Use the **"Shift+/"** key to toggle the overlay focus if you need to get around the desktop.

---

## Hotkey Reference

- **Start WibbleWobble:** SHIFT + END
- **Toggle UI:** SHIFT + END
- **Toggle overlay focus:** SHIFT + /
- **ReCentre tracking:** SHIFT + .
- **Switch Stereo eye order:** SHIFT + ,

---

## Configuration Workflows

- **Toggle UI:**  
  After launching WibbleWobble, toggle its UI with **Shift + End**.
  
- **Tool Box Window:**  
  The main WibbleWobble UI includes a Tool Box with configuration options.

### Rig Configuration

- Click **Rig Config** in the Tool Box to open the Rig Configuration window.
- Left mouse and drag within the screen visualiser rotates around the screens.
- Mouse scroll wheel while hovering the screen visualiser zooms in and out.
- Click **Edit Screen 0** to open the Screen Config.

### Edit Screen #

**Common Properties:**
- **Local Position (X, Y, Z) (m):** Screen position relative to your head.
- **Local Rotation (Pitch, Yaw, Roll) (°):** Euler angles in degrees.
- **Min U:** This represents the normalized horizontal coordinate on the texture that corresponds to the left edge of the screen.
- **Max U:** This represents the normalized horizontal coordinate on the texture that corresponds to the right edge of the screen.
- **Min V:** This represents the normalized vertical coordinate on the texture that corresponds to the top edge of the screen.
- **Max V:** This represents the normalized vertical coordinate on the texture that corresponds to the bottom edge of the screen.

**Flat Screen:**
- **Width/Height (m):** Visible area dimensions.

**Cylinder (Curved) Screen:**
- **Height (m)**: Visible area height.
- **Radius (m)**: Curve radius.
- **Fill Angle (°)**: Curve coverage in degrees.
- **Curve Steps**: Higher values result in a smoother curve.

### Client Config

- **Window Size (X, Y pixels):** Overlay window dimensions. Match your desktop/monitor with scaling disabled.
- **Source Format:**
  - Single:  The image coming from the game is expected to be a single view.
  - Side by Side: The image coming from the game is expected to be in stereoscopic side by side format.
  - Checkerboard: The image coming from the game is expected to be in checkerboard format.
- **Reshade Effects:**
  - Enabled: Captures image with Reshade effects.
  - Disabled: Captures image without Reshade effects.
- **Reprojection:**
  - Enabled: Uses head tracking for reprojection.
  - Disabled: No reprojection, just stretches the image.
- **VSYNC (0,1,2)**: Controls vertical sync options.
- **FrameRate (0 to ∞):** Limits client framerate. (0 = no limit)
- **DWM Flush:**
  - Enabled: Calls DWMFlush() after present.
  - Disabled: Default.
- **Beam Race Sync:**
  - Enabled: Another form of vsync for stereoscopic.
  - Disabled: Off.
- **Beam Race Scanline Count:** 
  - Scanline count to wait after vertical blank.
- **Stereo Thread:**
  - Enabled: Stereoscopic sync happens on a separate thread.
  - Disabled: Stereoscopic sync happens on the main thread.
- **Stereo Sync Delay Microseconds:**
  - The number of microseconds to delay stereo sync at the end of a frame.
- **DLP 3D Pixel Height:**
  - The height in pixels of the DLP 3D Ready signal line at the bottom of the screen for sequential output to DLP projectors. 0 == disabled.
  
### Game Config

- **Window Size (X,Y pixels):** WibbleWobble resizes the game window to these values.
- **FOV Vertical (°):** Vertical field of view of the game in degrees. This should match the field of view set in the game. Some games use an abstract value for this and it may not match 1:1. Changing this this value also recalculates FOV Horizontal to suit the game window aspect ratio.
- **FOV Horizontal (°):** Horizontal field of view of the game in degrees. This should match the field of view set in the game. Some games use an abstract value for this and it may not match 1:1. Changing this this value also recalculates FOV Vertical to suit the game window aspect ratio.
- **World Scale:** Usually leave at 1.0.
- **Frame Capture Delay:** Frame delay for reducing visual judder.
- **Axis Mappings (Yaw, Pitch, Roll):** Remap if the game’s axes differ.
- **Axis Multipliers (Yaw, Pitch, Roll, X, Y, Z):** Apply multipliers, including -1 to invert.

### Tracking Config

- **Device Name:**
  - Disabled: Not used.
  - Head: Device sets the head pose.
- **Lerp Multiplier:** Adjust head tracking extrapolation (1 = full, 0 = none).

### Stereo Config

- **COM Port:** Port for sending stereo sync signals (‘0’ for left eye, ‘1’ for right eye).
- **Frame Rate:** The expected frame rate of the client. 120 fps here means the client expects to produce a frame at 120fps and will take a frame from the game at 60fps. This number should match your monitors refresh rate.

---

## Triple Screen Guide 

 This is an example of setting up three screens in a conventional wrap around manner. 
 More or less than three screens can be added using similar principles.
 
- Enable NVidia surround or AMD Eyefinity so that your desktop is wrapped to your monitors.
- Enter the WibbleWobble UI with the Shift + End hotkey.
- Click on Client Config in the Tool Box window and set Window Size X and Window Size Y to match your desktop resolution.
- **OPTIONALLY** - Click on Client config in the Tool Box window and disable reprojection temporarily so you can see the texture mapped to all screens.
- Click on Rig Config in the Tool Box window.
- Add up to three screens by pressing the Add Screen button an appropriate amount of times.
- Click the Edit Screen buttons once for each screen to get an Edit Screen # window for each screen.
- For triple screens, order the screens left to right, Screen 0 on the left, Screen 1 in the middle and Screen 2 on the right.
- For each screen select the appropriate Screen Type and set the dimensions, curve properties, etc.
- For screen 0 decrease the Local Position X value to move it to the left.
- For screen 2 increase the Local Position X value to move it to the right.
- For screen 0 change the Local Rotation Yaw value to a negative angle in degress that matches the angle your side monitors relative to the centre monitor.
- For screen 2 change the Local Rotation Yaw value to a positive angle in degress that matches the angle your side monitors relative to the centre monitor.
- For screen 0 change the Max U value to 0.333333; this maps the right edge of screen 0 to one third of the texture in the horizontal direction.
- For screen 1 change the Min U value to 0.333333; this maps the left edge of screen 1 to one third of the texture in the horizontal direction.
- For screen 1 change the Max U value to 0.666666; this maps the right edge of screen 1 to two thirds of the texture in the horizontal direction.
- For screen 2 change the Min U value to 0.666666; this maps the left edge of screen 2 to two thirds of the texture in the horizontal direction.
- Sit in the position you will be sitting while playing and measure from your eyes to the centre monitor.
- Input this measurement in metres into the Local Position Z field of screen 1.
- For screen 0 and screen 1 adjust the Local Position X and Local Position Y values until the side screens line up with how they do in reality. You can perform measurements of the positions of your real screens to simplify this.
- In the Rig Config window click the Save button.
- **OPTIONALLY** - Click on Client config and re-enable reprojection to check your configuration.

![Triple Screen Guide](Documentation/Readme_triplescreen.png?raw=true)

---

## Stereoscopic Guide

- Soon

---

## Notes

- Any issues please raise an issue on GitHub and/or ask a question on the Discord.

---

## Support Me

- [Patreon](https://patreon.com/PHARTGAMES)

---

## Socials

- [Discord](https://discord.gg/gGUufTdpgG)


	
	