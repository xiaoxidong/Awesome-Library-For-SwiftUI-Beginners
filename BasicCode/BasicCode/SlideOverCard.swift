//
//  SlideOverCard.swift
//
//
//  Created by João Gabriel Pozzobon dos Santos on 30/10/20.
//

import SwiftUI

public struct SlideOverCardView<Content:View>: View {
    var isPresented: Binding<Bool>
    var position: Binding<CGPoint>
    var anchor: Binding<UnitPoint>
    var closeOnClickOutSide: Bool
    let onDismiss: (() -> Void)?
    
    var dragEnabled: Binding<Bool>
    var dragToDismiss: Binding<Bool>
    var displayExitButton: Binding<Bool>
    
    let content: Content
    
    public init(isPresented: Binding<Bool>, position: Binding<CGPoint>, anchor: Binding<UnitPoint>, closeOnClickOutSide: Bool, onDismiss: (() -> Void)? = nil, dragEnabled: Binding<Bool> = .constant(true), dragToDismiss: Binding<Bool> = .constant(true), displayExitButton: Binding<Bool> = .constant(true), content: @escaping () -> Content) {
        self.isPresented = isPresented
        self.position = position
        self.onDismiss = onDismiss
        self.dragEnabled = dragEnabled
        self.dragToDismiss = dragToDismiss
        self.displayExitButton = displayExitButton
        self.anchor = anchor
        self.closeOnClickOutSide = closeOnClickOutSide
        self.content = content()
    }
    
    @State var show = false
    
    @ViewBuilder
    public var body: some View {
        content
            .opacity(show ? 1 : 0)
            .scaleEffect(show ? 1 : 0, anchor: anchor.wrappedValue)
            .position(x: position.x.wrappedValue, y: position.y.wrappedValue)
            .animation(Animation.spring().speed(1.4))
//            .animation(Animation.spring(response: 0, dampingFraction: 2, blendDuration: 0.4).speed(0.6))
            .contentShape(Rectangle())
            .highPriorityGesture(
                TapGesture()
                    .onEnded {
                        if closeOnClickOutSide {
                            show = false
                            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { _ in
                                isPresented.wrappedValue = false
                            }
                        }
                    }
            )
            .onAppear {
                show = true
            }
            .edgesIgnoringSafeArea(.all)
    }
}

extension View {
    public func bottomSlideOverCard<Content:View>(isPresented: Binding<Bool>, closeOnClickOutSide: Bool = true, opacity: Double = 0.4, onDismiss: (() -> Void)? = nil, dragEnabled: Binding<Bool> = .constant(true), dragToDismiss: Binding<Bool> = .constant(true), displayExitButton: Binding<Bool> = .constant(true), @ViewBuilder content: @escaping () -> Content) -> some View {
        ZStack {
            self
            if isPresented.wrappedValue {
                VStack {
                    Color.black.opacity(isPresented.wrappedValue ? opacity : 0)
                        .animation(.linear(duration: 0.8))
                        //                    .animation(.spring(response: 0.35, dampingFraction: 1))
                        //                    .transition(AnyTransition.opacity.animation(Animation.default.speed(0.8)))
                        .onTapGesture {
                            if closeOnClickOutSide {
                                withAnimation {
                                    isPresented.wrappedValue = false
                                }
                            }
                        }
                }.transition(AnyTransition.opacity)
                .edgesIgnoringSafeArea(.all)
                .zIndex(1)
                
                VStack {
                    Spacer()
                    content()
                        .animation(.spring(response: 0.35, dampingFraction: 1))
                }.edgesIgnoringSafeArea(.all)
                .transition(AnyTransition.opacity.combined(with: .offset(x: 0, y: 200)).animation(Animation.default.speed(1.5)))
                .zIndex(2)
            }
        }
    }
    
    public func topSlideOverCard<Content:View>(isPresented: Binding<Bool>, closeOnClickOutSide: Bool = true, opacity: Double = 0.4, onDismiss: (() -> Void)? = nil, dragEnabled: Binding<Bool> = .constant(true), dragToDismiss: Binding<Bool> = .constant(true), displayExitButton: Binding<Bool> = .constant(true), @ViewBuilder content: @escaping () -> Content) -> some View {
        ZStack {
            self
            
            if isPresented.wrappedValue {
                Color.black.opacity(opacity)
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity)
                    .zIndex(1)
                    .animation(.spring(response: 0.35, dampingFraction: 1))
                    .onTapGesture {
                        if closeOnClickOutSide {
                            withAnimation {
                                isPresented.wrappedValue = false
                            }
                        }
                    }
                
                VStack {
                    content()
                        .animation(.spring(response: 0.35, dampingFraction: 1))
                    Spacer()
                }.edgesIgnoringSafeArea(.all)
                .transition(AnyTransition.opacity.combined(with: .offset(x: 0, y: -1000)).animation(Animation.default.speed(2)))
                .zIndex(2)
            }
        }
    }
    
    public func centerSlideOverCard<Content:View>(isPresented: Binding<Bool>, closeOnClickOutSide: Bool = true, opacity: Double = 0.4, onDismiss: (() -> Void)? = nil, dragEnabled: Binding<Bool> = .constant(true), dragToDismiss: Binding<Bool> = .constant(true), displayExitButton: Binding<Bool> = .constant(true), @ViewBuilder content: @escaping () -> Content) -> some View {
        ZStack {
            self
            
            if isPresented.wrappedValue {
                Color.black.opacity(opacity)
                    .edgesIgnoringSafeArea(.all)
                    
//                    .zIndex(1)
                    .transition(AnyTransition.opacity.animation(Animation.spring().speed(3)))
                    .onTapGesture {
                        if closeOnClickOutSide {
                            withAnimation {
                                isPresented.wrappedValue = false
                            }
                        }
                    }
                
                VStack {
                    Spacer()
                    content()
                        .padding(.horizontal, 26)
                        .animation(Animation.spring(response: 0, dampingFraction: 2, blendDuration: 0.4).speed(0.2))
                    Spacer()
                }
                .transition(AnyTransition.opacity.combined(with: .scale(scale: 0.8)).animation(Animation.default.speed(2)))
//                .zIndex(2)
            }
        }
    }
    
    public func dropSlideOverCard<Content:View>(isPresented: Binding<Bool>, closeOnClickOutSide: Bool = true, position: Binding<CGPoint>, anchor: Binding<UnitPoint>, opacity: Double = 0.4, onDismiss: (() -> Void)? = nil, dragEnabled: Binding<Bool> = .constant(true), dragToDismiss: Binding<Bool> = .constant(true), displayExitButton: Binding<Bool> = .constant(true), @ViewBuilder content: @escaping () -> Content) -> some View {
        ZStack {
            self
            
            if isPresented.wrappedValue {
                Color.black.opacity(0.01)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        if closeOnClickOutSide {
                            withAnimation {
                                isPresented.wrappedValue = false
                            }
                        }
                    }
                
                SlideOverCardView(isPresented: isPresented,
                                  position: position,
                                  anchor: anchor,
                                  closeOnClickOutSide: closeOnClickOutSide,
                                  onDismiss: onDismiss,
                                  dragEnabled: dragEnabled,
                                  dragToDismiss: dragToDismiss,
                                  displayExitButton: displayExitButton) {
                    content()
                }
            }
        }
    }
    
//    public func slideOverCard<Item:Identifiable, Content:View>(item: Binding<Item?>, onDismiss: (() -> Void)? = nil, dragEnabled: Binding<Bool> = .constant(true), dragToDismiss: Binding<Bool> = .constant(true), displayExitButton: Binding<Bool> = .constant(true), @ViewBuilder content: @escaping (Item) -> Content) -> some View {
//        let binding = Binding(get: { item.wrappedValue != nil }, set: { if !$0 { item.wrappedValue = nil } })
//        return ZStack {
//            self
//            self.bottomSlideOverCard(isPresented: binding, onDismiss: onDismiss, dragEnabled: dragEnabled, dragToDismiss: dragToDismiss, displayExitButton: displayExitButton, content: { content(item.wrappedValue!) } )
//        }
//    }
    
    private func conditionalAspectRatio(_ apply: Bool, _ aspectRatio: CGFloat? = .none, contentMode: ContentMode) -> some View {
        Group {
            if apply {
                self.aspectRatio(aspectRatio, contentMode: contentMode)
            } else { self }
        }
    }
}


