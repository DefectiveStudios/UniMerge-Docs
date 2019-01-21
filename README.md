# Get UniMerge
UniMerge can be [purchased](http://u3d.as/4XU) from the Unity Asset Store for only $15!

# Author

[Matt Schoen](mailto:schoen@defectivestudios.com) of [Defective Studios](http://www.defectivestudios.com)

## Intro
_At long last... a Unity GameObject merge/diff tool!_

Every team working with Unity knows the pain: you and another teammate both make major changes to a scene, or to the same prefab, and when it comes time to merge your changes into the game, it's "mine" or "theirs".  You can save your changes out as prefabs and bring them in manually, or keep one scene and have to duplicate the other scene's work, or simply fight to the death to decide whose work stays. Bah!

But no longer!  We're pleased to introduce to you: UniMerge, a handy tool for merging objects, prefabs, and whole scenes, with color-coded diffs directly in the Unity editor.  This way you can manipulate your objects with the interface you're already comfortable with, and you can see the results in the scene instantly!  The tool comes with some scripts and instructions to integrate with TortoiseGit and Git on Windows (more VCS and OS support soon!).  The workflow is also compatible with Unity's Asset Server.

_But why should this amazing tool exist?_

Merging Unity assets used to be impossible when scenes were binary-only. So, we dreamt of a tool to allow a user to compare two GameObjects and everything about them, in the same interface you use to edit the original objects. Now it exists, hooray!  

But, why exactly can't we merge via text?  There's a lot of extraneous information which is useful to Unity but really doesn't matter to us, and it seems that Unity does not maintain consistent ordering when saving scenes and prefabs (the real kicker).  When you go back to the merged scene, you can end up with duplicated and/or mangled objects in the scene.  

Now, we try to keep Git out of the equation and merge everything within Unity.  As long as you have a copy of each of the scenes or prefabs in question, you can get your changes back.  As long as you can see the object in Unity, you can actually make use of those changes and merge 'em in!

Anyway enough about the tool, here's how to use it!  Let's start with a very basic case.  We have two versions of some object and want to see if/how they are different.  Our job is to make them the saaaaame.

## How To Merge Objects
1. Open the ObjectMerge Window (Window -> Object Merge -> Object Merge)
2. Drag your objects from the scene to "mine" and "theirs" at the top of the window

That’s it!  Now you’ll see the interface in all its glory. If your objects are simple, there’s not much to inspect. If you have a more complicated object, you might get something like this:

So what’s going on here?? I’ll break it down:
<img src="https://github.com/DefectiveStudios/UniMerge-Docs/raw/master/breakdown.png" width=400 align=right />
1. **Options**: _Deep Copy_ will set references to objects you just copied in the object it was copied to.  Disable this if you don't want this behavior or if copying a large, complex object crashes Unity (sorry about that).  _Log_ will enable logging on certain operations.  _Compare Attributes_ will enable the inclusion of GameObject attributes (name, layer, tag, etc.) in the comparison algorithm.  _Expand Differences_ will open up any objects (and their parents) that have differences.  _Refresh_ will refresh the whole tree, comparing every object and attribute, resetting the row color.  Use this if anything seems fish or out of date, or if you make changes to the objects outside of the ObjectMerge window which can't be tracked.  _Row Height_ is pretty self-explanatory. Pick from one or three levels of padding between rows.
2. **Filters**: The drop-downs on the right will list every component type available in your project.  Use them like you use the layer mask GUI on lights and cameras to include/exclude component types from the comparison.  Those components will still show up red if there are differences, but they won't be checked in their parent object.  All three lists are checked simultaneously, and have to be broken up because Unity's mask GUI can only handle 31 items at a time.
3. **Root object slots**:  Drop your root objects here.  Once you fill both, the merge interface will magically appear!  Use the clear button if you want to get rid of the interface (for some reason).  The object picker breaks because we’re using a GUISkin for the window.  The _PrefabInstance_ you see below the object field tells you the prefab state of the object (this one happens to have no prefab).
4. **Foldouts**: GameObjects, Components, and some properties will be listed with a little arrow next to them.  As with everywhere else in the Unity interface, this arrow expands the contents below.  Note that all foldouts here are tied to both sides at once.  This is intentional in order to keep the layout sane and make it so that blank space means the object is actually missing.  Holding alt while clicking on a GameObject foldout will expand/collapse all of its children with it.
5. **Ping Button**: The Ping button will ping the object in the hierarchy, in case you need to do something with it in the scene.
6. **Mid buttons**: These have a lot of different states.  Generally speaking, the one on the left pertains to an object on the left, and the right to the right.  There’s one situation where a button exists but doesn't work - this is temporary.  If you try to copy an object to an empty space which is also empty in the parent, you’ll get a warning telling you to copy the parent over.  Moving on...
    * This set of buttons applies to a GameObject.  Soon I’ll be differentiating the rows visually, but either way, it is important to understand that these arrows do specific things. When copying between two existing GameObjects, this copies all components and properties in the direction of the arrow.  If you click the right button, the left side will override the right, and vice versa.
    * These arrows copy data between components.  All properties are copied.
    * These arrows copy data between properties.  Only the value at this row is copied.
    * Sometimes, when one side is missing, you’ll get an X on the side that has the object.  This will delete that object (or component), thus making that row the same by eliminating it.
    * Sometimes you won’t see buttons. This is because the opposite object is missing entirely (not just missing that component).  You will also get this for any properties of a missing component. You need to copy the component over to get those properties--you can’t copy them into nothing.
7. **Show/Hide**: The column on the right has two buttons that affect the entire row (not just one object). To differentiate between children and components, components are shown/hidden by a button instead of the foldout. There is a separator after each row which is usually the same color as the row. On GameObject rows, the separator can be green while the row is red. This signifies that attributes and components are the same, but there are differences in child GameObjects.
8. **Mismatched row**: If an object or component doesn't have a spouse (matching object on the other side), you will get an _X_ button on the side where it exists.  This button will destroy the object or component, thus making that row "equal" by getting rid of it.  You will not get copy buttons when showing components of a mismatched object.  You must first copy the object over to copy the components.  Note that you'll see empty space on the side without the object.

## Selection Cursor
Click on a row or press the up/down arrow to select rows. The selected row will be slightly darker than the other rows. You can use the following keyboard shortcuts to get around:
* Up/Down arrows to move to the previous/next row
* Shift + Up to collapse rows as you ascend into their parent
* Shift + Down to expand rows that have children
* Left/Right arrows to expand/collapse the selected row (if the row is a GameObject with no children, this will expand/collapse the components)
* Left on collapsed row to select its parent
* Right on an expanded row to select its first child with children
* Shift + Left on an collapsed GameObject row to collapse its attributes and components and select the parent
* Shift + Right on an expanded GameObject row to enter its attributes and components and select the next row with children
* Ctrl + Left/Right arrows to expand/collapse the selected row and its children recursively
* Alt + Up/Down to skip to the previous/next difference
* Alt + Left/Right to apply changes to the left/right (if possible)
* Ctrl + H to toggle (show/Hide) the components of the selected row if it is a gameobject

When skipping rows with alt + up/down, you will notice that the cursor will jump over expanded components and properties of objects that do not have a "spouse" in the opposite column. This is because all of these child rows are guaranteed to be different, and skipping to the next one is not providing useful information.

Note: By default, on OS X, Ctrl + Left/Right are bound to Mission Control previous/next desktop. To work around this, either disable those shortcut keys in System Preferences > Keyboard > Shortcuts, or simply hold shift + ctrl which will block OS X from using the shortcut, and work the same as ctrl in UniMerge.

## Pro Tips
* You can pull up any scene or prefab from any state by using TortoiseGit’s Repo Browser.  Open the log, find the commit you want, right click it and choose Repo Browser.  Then find the file you want, and Save as... to the assets folder. Then merge! Good Luck!
* The conflict check (red/green background) compares all components, fields, and child objects, but the part of the code that checks if children are "the same" only compares names.  The difference here is that in cases where an object on the left is not matched on the right, only names are considered.  There is no "history" to tell us whether two copies of a object used to be the same thing, so this is the best we can come up with so far.  Bear in mind that re-naming sub-objects will cause them to be treated as "unmatched" in this way.
* Don’t forget to use the normal Unity editor!  You can take advantage of multi-edit and other editor scripts you’ve devised and the rest, once you’ve found the differences with this window.  Sometimes it’s much easier to do things conventionally :)
* Make use of the alt-click and Expand Differences functionality.  Don't sit there folding out each object one-by-one when you can expand/collapse all by holding alt, and selectively expand to differences with the Expand Differences button.
* Be careful using the tool on large, complex scenes (more than a few thousand objects).  The tool will process in the background, but can still take a long time (over a minute) to refresh the comparison state of each object.  Break your scene up into chunks.  If you do decide to take the plunge and work on the whole thing at once, the comparison will run faster if you collapse the GUI down to showing just the top row.
* In Unity 5.3 and above, UniMerge makes use of the Unity SceneManager class.  Make sure that you don't have your own class called SceneManager, as it conflicts with the Unity class and will call compile errors when importing UniMerge.

## Scene Merging

Scene merging is pretty simple, too.  It also has a very similar workflow!  Simply do the following:

1. Open the SceneMerge Window (Window -> Object Merge ->Scene Merge)
2. Drag in your scenes
3. Press the Merge button
4. Merge your objects in the ObjectMerge window
5. Merge scene settings in the SceneMerge window
6. Click _Save / As Theirs/Mine_ to save either generated object to an existing or new scene file

You should be back where you started, with a merged scene :)

Note that you need to merge dependencies (a.k.a. prefabs) first.  If you try to merge a scene with prefabs containing version control markdown, Unity will spam the log with warnings, and the merge grinds to a halt.  In version 1.6 and above, UniMerge will abort the merge and warn you about this problem.

## Config Window
Generally speaking, you shouldn’t have to touch this window.  At the top of the window is a slider for controlling the UI responsiveness while UniMerge is performing long operations.  The value it is controlling is the number of milliseconds the UniMerge window will wait until yielding control back to Unity. Higher values result in faster refreshes, but less responsive Unity UI.  Everything here has to do with loading the custom skin for the colored backgrounds.  The text fields set name/path values that are used to load the skin and reference the custom styles that define the background colors.  There are 9 texture fields below these to override the default colors.

If you are red/green colorblind, just go ahead and drop some alternate colors into these textures.  You can either create a new set of 8 images, or edit the images themselves directly. If anyone comes up with some good alternate color schemes, I’d be happy to include them and a drop-down to switch between pre-made schemes.

## VCS/SCM Integration
Note that certain example paths below need to be changed based on your folder structure.  Also, the Windows merge-unity.vbs has a hard-coded path for Unity, which you might have to modify for your system.  Also, the script will assume that it's in the project folder for the project you want to work with, if you need to point to a different project, there is a commented line which will help you.

Unity has [some good instructions](http://docs.unity3d.com/Manual/SmartMerge.html) for a variety of VCS systems and their YAMLMerge tool.  For the record, this is another valid strategy if you want to deal with text files. I find that in the case of particularly messy merges, doing a YAML merge first can help make the input to UniMerge much more helpful.

### Regular Old Git
This is where it gets a bit complicated.  This was my first experience putting a custom merge driver into gitconfig, so if I’m doing it wrong, I won’t be surprised.  From what I can tell, there are two files you have to modify.  Note that this example would be a Windows set-up, calling the .vbs script with wscript.  Refer to the section below about OS X, and simply swap out the driver command below.  Add the following lines to the following files:

* <Git_Install_Path>/etc/gitconfig
```
*.unity		merge=unity
*.prefab	merge=unity
```
* <Local .git folder>/config
```
[merge "unity"]
	name = Unity merge
	driver = wscript.exe "D:/Documents/GimbalCop/GimbalCop/merge-unity.vbs" %A %B
```
### TortoiseGit
If you want to have this happen with TortoiseGit, go to TortoiseGit->Settings->Diff Viewer->Advanced... and add two rules:
```
Extension or mime-type: .unity
External Program: wscript.exe "D:\Documents\CosmoKnots\CosmoKnots\merge-unity.vbs" %base %mine
```
```
Extension or mime-type: .prefab
External Program: wscript.exe "D:\Documents\CosmoKnots\CosmoKnots\merge-unity.vbs" %base %mine
```
Next, go to TortoiseGit->Settings->Diff Viewer->Merge Tool->Advanced... and add two rules:
```
Extension or mime-type: .unity
External Program: wscript.exe "D:\Documents\CosmoKnots\CosmoKnots\merge-unity.vbs" %mine %theirs
```
```
Extension or mime-type: .prefab
External Program: wscript.exe "D:\Documents\CosmoKnots\CosmoKnots\merge-unity.vbs" %mine %theirs
```
Make sure you swap out D:\Documents\CosmoKnots\CosmoKnots\ with the path to your Unity project folder. Note that the script no longer uses relative paths, so you can put it wherever you want. You do, however, now have to go change the ProjectBase value to the path of your project folder.


I obviously have to figure out a better way to point to that script path.  Either way, that path will be the path to a VBS file that is run by the Windows Scripting Host (should be on all versions that support Unity).  This script will check if Unity is running and, depending on the state, do one of two things.  It will either (If Unity isn’t running) boot Unity and trigger the scene merge, or it will drop a file called merges.txt into the Assets folder.  If you have the SceneMerge window open, it will listen for that file drop and trigger a merge as soon as it updates.

This seems to work only on resolving conflicts.  I’m not exactly sure how to make it do this every time a scene or prefab merge happens.  The script is called but points at three files which don't exist.
Also, if you have unresolved conflicts in your ProjectSettings.asset file, Unity will assume a version mismatch and ask you to upgrade your project (don't do it!).  Not sure how to get around this.
Also, it only works on Windows.  It won’t be too big a deal to get it working on Mac/Linux.

Right now, the script doesn't clean up after itself since I don’t want it to be destructive while I work on it.  So you’ll have to delete the .REMOTE, .BASE, etc. files generated by Git in this process.

Not sure if there’s an automated way of setting up this process.  In lieu of tortoisegit, setting up a mergetool has always been kind of the bane of my git existence.  It’s pretty obscure and nobody seems to want to help you do it =/

### OS X and Git
superprat has been kind enough to create a  [github project](https://github.com/superprat/unimergemacdriver) for git integration on OS X.  His readme should explain how to set it up.
The merge-unity.sh script has been included in the latest version of the package.

### PlasticSCM on Windows
Just like with TortoiseGit, you want to have Plastic run the merge-unity.js script through wscript.exe.  Here is the command for the merge. You should set up two rules with this command, one for .unity, one for .prefab.

`wscript.exe "D:\Documents\CosmoKnots\CosmoKnots\merge-unity.vbs" @sourcefile @destinationfile`

Make sure you swap out D:\Documents\CosmoKnots\CosmoKnots\ with the path to your Unity project folder.  Note that the script no longer uses relative paths, so you can put it wherever you want.  You do, however, now have to go change the ProjectBase value to the path of your project folder.

### SourceTree
Atlassain SourceTree is becoming a popular git frontend for both OS X and Windows.  To configure SourceTree to use UniMerge as a diff tool, you can simply switch the diff and merge tool to "Other", and specify
```
wscript.exe "D:\Documents\CosmoKnots\CosmoKnots\merge-unity.vbs"
```
as the command, and
```
$LOCAL $REMOTE
```
as the arguments.

However, this means that unimerge will be used as the merge/diff tool for ALL file types. It seems that setting up SourceTree to specify a merge tool for specific filetypes is an [open issue](https://jira.atlassian.com/browse/SRCTREEWIN-487).  The suggestion about a shell script which processes the filetype and redirects commands to different merge tools is a valid one, but a project that I haven't taken on yet.
### Other VCS Integration
Integrating this tool into other VCS solutions should be very straightforward.  I'm not sure exactly how other systems specify mergetool overrides, but regardless you should be able to point them at a path which will open the bridge script.  We could either create a specific bridge for each VCS, or merge them all into a single script which would auto-detect which software was calling it.  Contact me if you want help setting up your VCS with the ObjectMerger.  Or, if you’ve figured it out already, I'd greatly appreciate it if you shared your bridge script and some instructions so that other users of your VCS don’t have to re-invent the wheel.

Anyways, that should be all.  Happy Merging!

I've included the integration scripts in this repo: [merge-unity.vbs](https://github.com/DefectiveStudios/UniMerge-Docs/blob/master/merge-unity.vbs) [merge-unity.sh](https://github.com/DefectiveStudios/UniMerge-Docs/blob/master/merge-unity.sh)

## Tests
The following tests will indicate whether any code changes have created issues in the tool.  For all merge tests, I’m going to assume mine -> theirs for the sake of semantics.  They should obviously work the same way in both directions
* Merge root object
    * Should destroy "theirs" object and duplicate "mine." Check that there are no errors
* Merge sub-object with no spouse
    * Should duplicate "mine" and make it a child of the object in "theirs" that corresponds to the first object’s parent.  If "theirs" has no such parent, a LogWarning will fire explaining why the merge can’t be done.  Additionally, if any GameObjects or Components in the first object’s tree are referenced by any object within "mine," the corresponding references should be set in "theirs".  If log is enabled it should print out all of the references that were set.
* Merge sub-object with spouse
    * Should copy all components, properties, and children into the spouse.  If log is enabled, any references which are set will be logged.
* Remove sub-object with no spouse
    * Should destroy the sub-object and set all references to it to null.  If logging is enabled, refs set to null are logged.
* Merge component with no spouse
    * Should create a new component on the other object and copy all property values. Also sets any references to the new component. If log is enabled, all set references will be logged.
* Merge component with spouse
    * Should copy all property values over.  No references are set, nothing is logged.
* Remove component with no spouse
    * Should destroy the component and set any references to it to null.  If logging is enabled, refs set to null are logged
* Merge property
    * Should set the value of the "theirs" property to that of "mine".  If the property references a component or GameObject, it attempts to copy the referenced object to the corresponding parent on "theirs." This will also find and set references like a regular copy.  If logging is enabled, ref settings and copy are logged.
* Refresh button
    * Should refresh the object and all of its children.  This will collapse children, and should set background colors right.
* Merge Scenes
    * You shouldn’t be able to click Merge or the Unpack buttons at first.  Once you drop in two scenes (you can actually use the same scene twice if you’re just testing), Merge should become enabled.  Once you hit merge, the ObjectMerge window will open, and you’ll be able to click the Unpack buttons.  As soon as you delete mine or theirs (or open another scene), the corresponding button should ghost out.  Clicking Unpack should unpack one or the other object  and delete both container objects.
* Git integration
    * This is a little tough to test.  Git should try to open Unity if it isn’t running whenever a scene or prefab is merged, and/or when you try to resolve a conflicted merge.  In some cases, the git integration doesn’t work because it doesn’t create copies of the scene to be opened in Unity
If Unity is already open when the merge happens, and you have the SceneMerge window up, it will listen for a certain file that the bridge script will create and open the scenes or prefabs automatically.
* Integration tests
    * I've added some automated tests which open the ObjectMerge and SceneMerge windows and do a simple merge on the demo data. I would like to flesh these out, but they cover most of the breakages I've seen, which happen in the window startup and initial refresh.

## Known Issues
* The license is a little sketchy.  The project isn’t strict open-source but I want to allow people to modify the code and share their modifications. There must be a license for this out there...
* You can't use this to recover missing references due to guid mismatches.  In other words, if you bring in the original scene and it has missing references (sometimes this even happens with references within the scene), the tool won't help you find them.  This is a broader issue with Unity's asset management which is hard to trace and ultimately probably impossible to solve without using a central authority for guids.  Any advice on how to handle this better is welcome.
* We only match objects by name, and sort alphanumerically to account for change in order. Thus, you can't merge changes in sibling order

### A Note on Nested Prefabs
Prefabs have always been a tricky situation for UniMerge. For one thing, you always have to resolve prefab merge conflicts first, because you won't even be able to load them with diff markers in the file. As such, you have always had to resolve prefab conflicts in isolation, which means that some scene references or overrides can be lost in the process. Furthermore, preserving prefab links in a "whole object" merge operation has thus far been a bit of a hack. The process worked by deleting the target object, cloning the source, and putting the new object in the place where the target once was, and linking the cloned object to the source object's prefab. Deleting sub-objects via the ObjectMerge window would break prefab links as would normally happen when doing so in the hierarchy.
The nested prefabs workflow introduced in 2018.3 forces you to make "breaking" changes in the prefab isolation mode. As such, you simply _cannot_ delete objects that are part of a prefab outside of isolation mode. That throws a wrench in the UniMerge workflow, in that we have always been able to edit two prefabs side-by-side in a single scene. I think there may be ways to work around this in the future, but for now the solution is to simply interrupt the UniMerge operation when we need to delete child objects within prefabs. Unimerge displays a replica of the normal Unity dialog informing you that you either need to unpack your prefab (formerly "break prefab link") or enter isolation mode. Opening the prefab can be helpful to make a simple tweak, but if you want to properly diff two prefabs, just unpack them in the scene, merge your changes, and save that object back to the prefab you wish to keep.

## Roadmap
What’s next?
* VCS integration
    * A helpful user has contributed an OS X git bridge. Still waiting on demand for systems like Perforce or Mercurial.  Note: for systems like SVN that don't handle merging, there's nothing to be done.  The tool works as well as possible as-is!
* Better filtering
    * The current UI is a little awkward, and you can only filter by component type.  I’d also like to filter out property names and/or object names
* Merging lists of objects
    * Currently, for the purposes of merging two parallel lists of children, only object names are compared.  For example, we have one object with Child 1, Child 2, and Child 3, and another with Child 2, Child 3, and Child 4.  As it stands, we’ll see a list with 4 items.  Since there is no child named Child 1 it will be alone on the left, and likewise Child 4 will be alone on the right.  It might be appropriate to merge the list differently, and we’d be able to make a better decision with information about the object’s history.  Anyway this is an area for improvement, but I have no idea what would be better.
* "Smarter" merging/merge options
    * Currently the "merge" buttons in the middle will simply copy the object over wholesale.  As a first step in the direction of "smart" merging, the tool will try to maintain references to the object and its children and components, but there could be other merge strategies that could avoid overwriting other objects, or something like that.
* Skinning/GUI
    * The GUI is rather simple as-is but is still pretty busy.  I’m constantly thinking about ways to improve it.
* Refresh behavior
    * When changes are made, the entire tree is refreshed. This takes longer the first time because we create a bunch of objects, and actions must bubble all the way up to the root because otherwise parents wouldn't know about conflict resolutions in their children. However, siblings don't need to be refreshed. This can be accounted for with a little bit of added complexity to the Refresh method.
* Documentation
    * I hope to add some more screencasts and better screenshots of tool in action.  The [demo screencast](https://www.youtube.com/watch?v=SWmca1Ozntw) is a good start, though!
* Code cleanup
    * Refresh always traverses the entire tree, and FindAndSetRefs is O(n^2).  I might be able to make these operations faster
* Three way merge
    * I'm still scratching my head on the UI for this one, but I do plan to tackle it. The standard 3-over-1 layout seems like a terrible idea for this purpose, but it is clear that seeing the base/local/remote versions at least is necessary.
