//
//  AddressView.swift
//  Cupcake Corner
//
//  Created by Ahmed Mgua on 8/16/20.
//

import SwiftUI

struct AddressView: View {
	@ObservedObject	var	order:	Order
	
	@State	private	var	showingCheckout	=	false
	
	
	var body: some View {
		
//		VStack {
			Form	{
				Section	{
					TextField("Name",	text:	$order.name)
					TextField("Street Address",	text:	$order.streetAddress)
					TextField("City",	text:	$order.city)
					TextField("Zip Code",	text:	$order.zip)
				}.navigationBarTitle("Delivery Details",	displayMode:	.inline)
			
			Section	{
				NavigationLink(destination:	CheckoutView(order:	order))	{
					Text("Proceed to Checkout")
						//			Button("Proceed to Checkout")	{
						//				self.showingCheckout	=	true
						//			}
//						.padding()
					
					//			.cornerRadius(10)
					//			.disabled(order.hasValidAddress	==	false)
					
				}.disabled(order.hasValidAddress	==	false)
				
			}
			//		.sheet(isPresented: $showingCheckout, content: {
			//			CheckoutView(order: order)
			//		})
			
			
		}
	}
}
	
	
	
	struct AddressView_Previews: PreviewProvider {
		static var previews: some View {
			AddressView(order:	Order())
		}
	}
