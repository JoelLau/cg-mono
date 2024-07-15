import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { HeaderComponent } from "../components/header.component";

@Component({
  selector: 'app-stack-layout',
  standalone: true,
  imports: [CommonModule, HeaderComponent],
  templateUrl: './stack-layout.component.html',
  styleUrl: './stack-layout.component.scss',
})
export class StackLayoutComponent {}
