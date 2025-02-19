//
//  HandleRSwitch.swift
//  RSwitch
//
//  Created by hrbrmstr on 8/24/19.
//  Copyright © 2019 Bob Rudis. All rights reserved.
//

import Foundation
import Cocoa

extension AppDelegate {
  
  // The core worker function. Receives the basename of the selected directory
  // then removes the current alias and creates the new one.
  @objc func handleRSwitch(_ sender: NSMenuItem?) {
    
    let fm = FileManager.default;
    let title = sender?.title
    let rm_link = (RVersions.macos_r_framework) + "/" + "Current"

    do {
      try fm.removeItem(atPath: rm_link)
    } catch {
      self.notifyUser(title: "Action failed", text: "Failed to remove 'Current' alias" + rm_link)
    }
    
    do {
      try fm.createSymbolicLink(
            at: NSURL(fileURLWithPath: RVersions.macos_r_framework + "/" + "Current") as URL,
            withDestinationURL: NSURL(fileURLWithPath: RVersions.macos_r_framework + "/" + title!) as URL
      )
      self.notifyUser(title: "Success", text: "Current R version switched to " + title!)
    } catch {
      self.notifyUser(title: "Action failed", text: "Failed to create alias for " + RVersions.macos_r_framework + "/" + title! + " (\(error))")
    }
      
  }

}
