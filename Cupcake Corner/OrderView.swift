//
//  OrderView.swift
//  Cupcake Corner
//
//  Created by Ahmed Mgua on 8/11/20.
//

import SwiftUI

struct OrderView: View {
	@State private var	results	=	[Result]()
	
	@ObservedObject	var order	=	Order()

	var body: some View	{
		
		NavigationView	{
			Form	{
				Section	{
					Picker("Select your cake type",	selection:	$order.type)	{
						ForEach(0..<Order.types.count,	id:	\.self)	{
							Text(Order.types[$0])
						}
					}.padding()
					
					Stepper(value: $order.quantity, in:	3...20)	{
						Text("Quantity: \(order.quantity)")
					}.padding()
				}
				.navigationTitle("Order")
				
				Section	{
					Toggle(isOn: $order.specialRequestEnabled.animation())	{
						Text("Add a topping")
					}
					
					if order.specialRequestEnabled	{
						Toggle(isOn:	$order.extraFrosting)	{
							Text("Extra frosting")
						}
						
						Toggle(isOn:	$order.addSprinkles)	{
							Text("Add sprinkles")
						}
					}
				}
				
				Section	{
					NavigationLink(destination:	AddressView(order: order))	{
						Text("Delivery details")
					}
				}
			}
		}
		
	}
}




struct Response:	Codable {
	var results:	[Result]
}

struct 	Result:	Codable {
	var trackId:	Int
	var trackName:	String
	var collectionName:	String
	
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		OrderView()
	}
}
