//
//  Project.swift
//  NewestGithub
//
//  Created by Mark Meretzky on 11/30/18.
//  Copyright © 2018 New York University School of Professional Studies. All rights reserved.
//

import Foundation;

//The TableViewController has an array of Project structures.
//This array constitutes the model (as in Model-View-Controller).
//Each Project structure contains a name and the time when it was most recently updated on GitHub.


struct Project {
    let name: String;    //e.g., "accountname/projectname".  Does not include the "WS18SCA01-".
    let updated: String; //e.g., "2018-11-30T14:04:05Z".  The "Z" stands for Zulu time.
};
