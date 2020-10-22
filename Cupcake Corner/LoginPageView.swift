//
//  OrderView.swift
//  Cupcake Corner
//
//  Created by Ahmed Mgua on 8/16/20.
//

import SwiftUI

struct LoginPageView: View {
	@State private var username	=	""
	@State private var email	=	""
	
	var disabledForm:	Bool	{
		username.isEmpty	||	email.isEmpty
	}
	
    var body: some View {
		Form	{
			Section	{
				TextField("Username",	text:	$username)
				TextField("Email",	text:	$email)
			}
			Section	{
				Button("Create account")	{
					print("Creating account...")
				}
			}.disabled(disabledForm)
		}
		
	}
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}
