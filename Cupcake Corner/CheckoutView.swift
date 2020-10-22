//
//  CheckoutView.swift
//  Cupcake Corner
//
//  Created by Ahmed Mgua on 8/17/20.
//

import SwiftUI

struct CheckoutView: View {
	@ObservedObject var order:	Order
	
	@State 	private var	alertMessage	=	""
	@State	private var	showingAlert	=	false
	
	func placeOrder()	{
		guard let encoded	=	try?	JSONEncoder().encode(order)	else	{
			print("Failed to encode order")
			return
		}
		
		let url	=	URL(string: "https://reqres.in//api/cupcakes")!
		var request	=	URLRequest(url: url)
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		request.httpMethod	=	"POST"
		request.httpBody	=	encoded
		
		URLSession.shared.dataTask(with:	request)	{	data,	response,	error	in
			guard let data	=	data	else	{
				print("No data in response: \(error?.localizedDescription	??	"Unknown error").")
				return
			}
			
			if let decodedOrder	=	try?	JSONDecoder().decode(Order.self, from: data)	{
				self.alertMessage	=	"Your order for \(decodedOrder.quantity) \(Order.types[decodedOrder.type].lowercased()) cupcakes has been received. Sit tight!"
				self.showingAlert	=	true
			}	else	{
				print("Invalid response from server")
			}
			
		}.resume()
		
	}
	var body: some View {
		GeometryReader	{	geo in
			ScrollView	{
				VStack	{
					Image("cupcakes")
						.resizable()
						.scaledToFit()
						.cornerRadius(20)
						.shadow(color: Color.init(red: 193	/	255, green: 223	/	255, blue: 233	/	255).opacity(0.5), radius: 10,	y:	-10)
						.shadow(color: Color.init(red: 227	/	255, green: 207	/	255, blue: 224	/	255).opacity(0.5), radius: 10,	y:	10)
						.padding()
						.frame(width: geo.size.width)
					
					
					HStack {
						Text("Your total is:")
							.font(.title)
							.padding()
						Text("$\(self.order.cost,	specifier: "%.2f")")
							.font(.title)
							.padding()
						
					}
					
					Button("Place Order")	{
						self.placeOrder()
					}
					.foregroundColor(.primary)
					.padding()
					.background(
						LinearGradient(gradient: Gradient(colors: [Color.init(red: 193	/	255, green: 223	/	255, blue: 233	/	255).opacity(0.5), Color.init(red: 227	/	255, green: 207	/	255, blue: 224	/	255).opacity(0.5)]), startPoint: .leading, endPoint: .trailing)
					)
					.cornerRadius(10)
					.shadow(color: Color.init(red: 193	/	255, green: 223	/	255, blue: 233	/	255).opacity(0.7), radius: 10,	y:	-10)
					.shadow(color: Color.init(red: 227	/	255, green: 207	/	255, blue: 224	/	255).opacity(0.7), radius: 10,	y:	10)
				}.navigationBarTitle("Check out",	displayMode:	.inline)
			}
		}
		.alert(isPresented: $showingAlert, content: {
			Alert(title: Text("Thank you!"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
		})
		
		
	}
}

struct CheckoutView_Previews: PreviewProvider {
	static var previews: some View {
		CheckoutView(order:	Order())
	}
}
