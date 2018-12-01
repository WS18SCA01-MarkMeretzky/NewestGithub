//
//  TableViewController.swift
//  NewestGithub
//
//  Created by Mark Meretzky on 11/30/18.
//  Copyright © 2018 New York University School of Professional Studies. All rights reserved.
//

/*
 How to create this project
 
 1.  In Xcode, File -> New -> Project...
 Select iOS, Single View App.
 Create a new project named NewestGithub.
 
 2.  In Xcode, File -> New -> File...
 Select iOS, Swift File
 Save As: Project.swift
 In the Project navigator, put your new file Project.swift
 under the existing file ViewController.swift.
 Edit Project.swift so it looks like the Project.swift file in this project.
 
 3.  In Xcode, File -> New -> File...
 Select iOS, Cocoa Touch Class
 Class: TableViewConroller
 Subclass of: UITableViewController
 In the Project navigator, put your new file TableViewController.swift
 under the existing file ViewController.swift.
 Edit TableViewController.swift so it looks like the TableViewController.swift file in this project,
 except don't write the action refreshButtonPressed.  We'll create that action later.
 
 4.  In the Project navigator, select Main.storyboard.
 In the Outline view to the left of the Canvas, select the View Controller Scene.
 Press the Macintosh delete key to delete the View Controller Scene.
 You now have no scenes.
 
 5.  Drag a Table View Controller out of the Objects Library into the Canvas.
 Your Outline view should now have a Table View Controller Scene.

 6.  In the Outline view to the left of the Canvas, select your new Table View Controller.
 In the Identity inspector, change the class of the Table View Controller
 from UITableViewController to TableViewController.
 In the Attribute inspector check Is Initial View Controller.
 In the Canvas, the left edge of your table view controller should now have the Storyboard entry point arrow.
 
 7.  In the Outline view, select the Table View Cell under the Table View Controller.
 In the Attributes inspector, change the Style from Custom to Subtitle
 and change the Identifier to projectCell.

 8.  In the Outline view, select the Table View Controller.
 Editor -> Embed In -> Navigation Controller
 Your Outline View should now have a Navigation Controller Scene and a Table View Controller Scene.
 
 9.  In the Outline view, select the Navigation Item under the Table View.
 (The Navigation Item is the bar acrosss the top of the app's screen.)
 Drag a Bar Button Item out of the Objects Library onto the right end of the Navigation Item.
 In the outline view, select your new Item under Right Bar Button Items under Navigation Item.
 In the Attributes inspector, change System Item from Custom to Refresh.
 
 10.  Open the Assistant Editor.  Control-drag a straight blue line out of your new Refresh
 button to create an action named refreshButtonPressed.  The type of the action should be Any.
 The action should contain one statement: updateModelAndUI();
 
 11.  In Xcode, File -> New -> File...
 Select iOS, Cocoa Touch Class
 Class: WebViewConroller
 Subclass of: UIViewController
 Edit WebViewController.swift so it looks like the WebViewController.swift file in this project,
 
 12.  In the Project navigator, select Main.storyboard.
 Drag a View Controller out of the Objects Library onto the Canvas, to the right of the existing table view.
 In the Outline view, select the new view controller.
 In the Identity inspector, change the class of the new view controller
 from UIViewController to WebViewController.
 
 13.  In the Outline view, select the projectCell under the table view.
 Control-drag from the project cell to your new web view controller.
 In the little black window that appears when you release the straight blue line,
 select Show under Selection Segue.
 This creates a segue arrow from the table view to the web view.
 
 14.  In the Canvas, select the new arrow you just created.  This arrow represents a "segue".
 In the Attributes inpector, give it the identifier showWebPage.
 This identifier is used in the prepare method of the table view controller.
*/

import UIKit;

class TableViewController: UITableViewController {
    
    var projects: [Project] = [Project]();   //the model (as in Model-View-Controller)
    
    override func viewDidLoad() {
        super.viewDidLoad();
        updateModelAndUI();
        navigationItem.title = "Newest GitHub Projects";
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false;

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    }
    
    //Called by viewDidLoad and refreshButtonPressed.
    
    func updateModelAndUI() {
        let urlString: String = "https://api.github.com/search/repositories"
            + "?q=WS18SCA01-"      //Search for repositories that have WS18SCA01- in their name.
            + "+in:name"
            + "+sort:updated-desc" //The most recently updated repositories first. "desc" means descending.
            + "&per_page=100";     //Get at most 100 repositories.
        
        guard let url: URL = URL(string: urlString) else {
            print("could not create URL for \(urlString)");
            return;
        }
        
        let sharedSession: URLSession = URLSession.shared;
        let downloadTask: URLSessionDownloadTask = sharedSession.downloadTask(with: url, completionHandler: complete);
        downloadTask.resume();
    }

    @IBAction func refreshButtonPressed(_ sender: Any) {
        updateModelAndUI();
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return projects.count;
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath);

        // Configure the cell...
        //A cell whose style is UITableViewCell.CellStyle.subtitle
        //contains a big textLabel and a smaller detailTextLabel below it, both left justified.
        let project: Project = projects[indexPath.row];
        cell.textLabel!.text = project.name;
        cell.detailTextLabel!.text = project.updated;
        return cell;
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation.
    //Called when the user selects a cell.  Tell the web view controller which project to display.
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender);
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        switch(segue.identifier ?? "") {
            
        case "showWebPage":
            guard let webViewController: WebViewController = segue.destination as? WebViewController else {
                fatalError("Unexpected destination: \(segue.destination)");
            }
            
            guard let selectedCell: UITableViewCell = sender as? UITableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))");
            }
            
            guard let indexPath: IndexPath = tableView.indexPath(for: selectedCell) else {
                fatalError("The selected cell is not being displayed by the table");
            }
            
            let selectedProject: Project = projects[indexPath.row];
            webViewController.name = selectedProject.name;
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }

}

//Called by updateModelAndUI when the download is complete.

func complete(filename: URL?, response: URLResponse?, error: Error?) {
    print("complete");
    
    if (error != nil) {
        print("could not download data from GitHub server: \(error!)");
        return;
    }
    
    guard let filename: URL = filename else {
        print("The filename was nil.");
        return;
    }
    
    //Arrive here when the data from the GitHub has been
    //downloaded into a file in the device.
    
    //Copy the data from the file into a Data object.
    
    let data: Data;
    do {
        data = try Data(contentsOf: filename);
    } catch {
        print("Could not create Data object.");
        return;
    }
    //print(String(data: data, encoding: .utf8)!)
    
    let object: [String: Any];   //a dictionary
    
    do {
        object = try JSONSerialization.jsonObject(with: data) as! [String: Any];
    } catch {
        print("could not create dictionary: \(error)");
        return;
    }
    
    guard let projects: [[String: Any]] = object["items"] as? [[String: Any]] else { //array of dictionaries
        print("JSON did not have array of items.");
        return;
    }
    
    var githubProjects: [Project] = [Project]();
    
    for project in projects {
        guard var full_name: String = project["full_name"] as? String else {
            print("JSON item did not have full_name.");
            continue;
        }
        
        if let range: Range = full_name.range(of: "WS18SCA01-") {
            //Chop off the leading "WS18SCA01-".
            full_name = String(full_name[range.upperBound ..< full_name.endIndex]);
        }
        
        guard var updated_at: String = project["updated_at"] as? String else {
            print("JSON item \(full_name) did not have updated_at.");
            continue;
        }
        
        //Change "T" to 2 spaces.
        
        if let i: String.Index = updated_at.firstIndex(of: "T") {
            updated_at.replaceSubrange(i ... i, with: "  ");
        }
        
        let project: Project = Project(name: full_name, updated: updated_at);
        githubProjects.append(project);
    }
    
    DispatchQueue.main.async {
        //The following statements are executed by the main thread.
        let navigationController: UINavigationController = UIApplication.shared.keyWindow!.rootViewController as! UINavigationController;
        let tableViewController: TableViewController = navigationController.topViewController as! TableViewController;
        tableViewController.projects = githubProjects;
        tableViewController.tableView.reloadData();
    }
}

