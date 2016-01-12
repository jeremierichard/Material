/*
* Copyright (C) 2015 - 2016, Daniel Dahan and CosmicMind, Inc. <http://cosmicmind.io>.
* All rights reserved.
*
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are met:
*
*	*	Redistributions of source code must retain the above copyright notice, this
*		list of conditions and the following disclaimer.
*
*	*	Redistributions in binary form must reproduce the above copyright notice,
*		this list of conditions and the following disclaimer in the documentation
*		and/or other materials provided with the distribution.
*
*	*	Neither the name of GraphKit nor the names of its
*		contributors may be used to endorse or promote products derived from
*		this software without specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
* AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
* IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
* DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
* FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
* DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
* SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
* CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
* OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
* OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

/*

*/

import UIKit
import MaterialKit

private struct Item {
	var text: String
	var detail: String
	var image: UIImage?
}

class AMainViewController: UIViewController {
	/// A tableView used to display Bond entries.
	private let tableView: UITableView = UITableView()
	
	/// A list of all the Author Bond types.
	private var items: Array<Item> = Array<Item>()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		prepareView()
		prepareItems()
		prepareTableView()
		prepareNavigationBarView()
		prepareMaterialKitButton()
	}
	
	/**
	Handles the menu button click, which opens the
	SideNavigationViewController.
	*/
	func handleMenuButton() {
		sideNavigationViewController?.open()
	}
	
	/// Prepares view.
	private func prepareView() {
		view.backgroundColor = MaterialColor.white
	}
	
	/// Prepares the items Array.
	private func prepareItems() {
		items.append(Item(text: "Summer BBQ", detail: "Wish I could come, but I am out of town this weekend.", image: UIImage(named: "Profile1")))
		items.append(Item(text: "Birthday gift", detail: "Have any ideas about what we should get Heidi for her birthday?", image: UIImage(named: "Profile2")))
		items.append(Item(text: "Brunch this weekend?", detail: "I'll be in your neighborhood doing errands this weekend.", image: UIImage(named: "Profile3")))
		items.append(Item(text: "Giants game", detail: "Are we on this weekend for the game?", image: UIImage(named: "Profile4")))
		items.append(Item(text: "Recipe to try", detail: "We should eat this: Squash, Corn and tomatillo Tacos.", image: UIImage(named: "Profile5")))
		items.append(Item(text: "Interview", detail: "The candidate will be arriving at 11:30, are you free?", image: UIImage(named: "Profile6")))
		items.append(Item(text: "Book recommendation", detail: "I found the book title, Surely You’re Joking, Mr. Feynman!", image: UIImage(named: "Profile7")))
		items.append(Item(text: "Oui oui", detail: "Do you have Paris recommendations? Have you ever been?", image: UIImage(named: "Profile8")))
	}
	
	/// Prepares the tableView.
	private func prepareTableView() {
		tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
		tableView.dataSource = self
		tableView.delegate = self
		
		// Use MaterialLayout to easily align the tableView.
		view.addSubview(tableView)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		MaterialLayout.alignToParent(view, child: tableView, top: 70)
	}
	
	/// Prepares the navigationBarView.
	private func prepareNavigationBarView() {
		let navigationBarView: NavigationBarView = NavigationBarView()
		navigationBarView.backgroundColor = MaterialColor.blue.base
		
		/*
		To lighten the status bar - add the
		"View controller-based status bar appearance = NO"
		to your info.plist file and set the following property.
		*/
		navigationBarView.statusBarStyle = .LightContent
		
		// Title label.
		let titleLabel: UILabel = UILabel()
		titleLabel.text = "Inbox"
		titleLabel.textAlignment = .Left
		titleLabel.textColor = MaterialColor.white
		titleLabel.font = RobotoFont.regularWithSize(20)
		navigationBarView.titleLabel = titleLabel
		navigationBarView.titleLabelInset.left = 64
		
		// Detail label.
		let detailLabel: UILabel = UILabel()
		detailLabel.text = "Count: \(items.count)"
		detailLabel.textAlignment = .Left
		detailLabel.textColor = MaterialColor.white
		detailLabel.font = RobotoFont.regularWithSize(12)
		navigationBarView.detailLabel = detailLabel
		navigationBarView.detailLabelInset.left = 64
		
		// Menu button.
		let img1: UIImage? = UIImage(named: "ic_menu_white")
		let menuButton: FlatButton = FlatButton()
		menuButton.pulseColor = MaterialColor.white
		menuButton.pulseFill = true
		menuButton.pulseScale = false
		menuButton.setImage(img1, forState: .Normal)
		menuButton.setImage(img1, forState: .Highlighted)
		menuButton.addTarget(self, action: "handleMenuButton", forControlEvents: .TouchUpInside)
		
		// Add menuButton to left side.
		navigationBarView.leftButtons = [menuButton]
		
		// Search button.
		let img2: UIImage? = UIImage(named: "ic_search_white")
		let searchButton: FlatButton = FlatButton()
		searchButton.pulseColor = MaterialColor.white
		searchButton.pulseFill = true
		searchButton.pulseScale = false
		searchButton.setImage(img2, forState: .Normal)
		searchButton.setImage(img2, forState: .Highlighted)
		
		// Add searchButton to right side.
		navigationBarView.rightButtons = [searchButton]
		
		// To support orientation changes, use MaterialLayout.
		view.addSubview(navigationBarView)
		navigationBarView.translatesAutoresizingMaskIntoConstraints = false
		MaterialLayout.alignFromTop(view, child: navigationBarView)
		MaterialLayout.alignToParentHorizontally(view, child: navigationBarView)
		MaterialLayout.height(view, child: navigationBarView, height: 70)
	}
	
	/// Prepares the MaterialKit button.
	func prepareMaterialKitButton() {
		let image: UIImage? = UIImage(named: "ic_materialkit_white")
		let button: FabButton = FabButton()
		button.setImage(image, forState: .Normal)
		button.setImage(image, forState: .Highlighted)
		
		view.addSubview(button)
		button.translatesAutoresizingMaskIntoConstraints = false
		MaterialLayout.alignFromBottomRight(view, child: button, bottom: 16, right: 16)
		MaterialLayout.size(view, child: button, width: 56, height: 56)
	}
}

/// TableViewDataSource methods.
extension AMainViewController: UITableViewDataSource {
	/// Determines the number of rows in the tableView.
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count;
	}
	
	/// Returns the number of sections.
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	/// Prepares the cells within the tableView.
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell: UITableViewCell = UITableViewCell(style: .Subtitle, reuseIdentifier: "Cell")
		
		let item: Item = items[indexPath.row]
		cell.selectionStyle = .None
		cell.textLabel!.text = item.text
		
		cell.detailTextLabel!.text = item.detail
		cell.detailTextLabel!.textColor = MaterialColor.grey.darken4
		
		cell.imageView!.image = item.image?.resize(toWidth: 36)
		cell.imageView!.layer.cornerRadius = 18
		return cell
	}
	
	/// Prepares the header within the tableView.
	func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let view = UIView()
		view.backgroundColor = MaterialColor.white
		
		let label: UILabel = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = RobotoFont.mediumWithSize(16)
		label.textColor = MaterialColor.grey.base
		label.text = "Today"
		
		view.addSubview(label)
		MaterialLayout.alignToParent(view, child: label, left: 16)
		return view
	}
}

/// UITableViewDelegate methods.
extension AMainViewController: UITableViewDelegate {
	/// Sets the tableView cell height.
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 80
	}
	
	/// Sets the tableView header height.
	func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 48
	}
}
