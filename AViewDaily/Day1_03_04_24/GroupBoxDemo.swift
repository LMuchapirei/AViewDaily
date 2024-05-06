//
//  GroupBoxDemo.swift
//  AViewDaily
//
//  Created by Linval Muchapirei on 3/5/2024.
//

import SwiftUI

struct GroupBoxDemo: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.pink.gradient.opacity(0.8))
                .ignoresSafeArea()
            VStack(spacing:40) {
                GroupBox("My Content"){
                    Text("Test group box ,it a very nice view that dynamically handles text as it gets wider, it wraps onto a new line")
                }
                .frame(width: 340)
                .groupBoxStyle(.music)
                GroupBox {
                    GroupBox {
                        MusicPlayerView()
                    }
                    .groupBoxStyle(.music)
                } label: {
                    Label("Now Playing",systemImage: "music.note")
                       
                }
                .groupBoxStyle(.music)
            }
            .padding()
        }
    }
}

/// this is some interesting way to create custom modifiers
extension GroupBoxStyle where Self == MusicGroupBoxStyle {
    static var music: MusicGroupBoxStyle {
        .init()
    }
}


struct MusicGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment:.leading) {
            configuration.label
                .bold()
                .foregroundStyle(.pink)
            configuration.content
        }
        .padding()
        .background(.regularMaterial,in:RoundedRectangle(cornerRadius: 12))
    }
}

struct MusicPlayerView: View {
    var body: some View {
        VStack {
            HStack {
                RoundedRectangle(cornerRadius: 8)
                    .frame(width:50,height: 50)
                    .foregroundStyle(.secondary)
                VStack(alignment:.leading,spacing: 2){
                    Text("Cool song title")
                        .font(.headline.bold())
                    
                    Text("Artist Name")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                Spacer()
            }
            .padding(.bottom,8)
            
            ProgressView(value:0.4,total: 1)
                .tint(.secondary)
                .padding(.bottom,20)
            
            HStack(spacing:30){
                Image(systemName: "backward.fill")
                Image(systemName: "pause.fill")
                Image(systemName: "forward.fill")
            }
            .foregroundStyle(.secondary)
            .font(.title)
        }
    }
}


#Preview {
    GroupBoxDemo()
}

/// https://www.youtube.com/watch?v=NvE3SaGGurQ
//// What did we learn here
///
///
/// creating custom modifier and calling it, using a custom init via an extension on the parent type
